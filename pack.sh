#!/bin/bash
set -euo pipefail

echo "========================================="
echo "  打包 NPU 项目代码"
echo "========================================="

# 0. 检查 git 状态，决定包名
COMMIT_HASH=$(git rev-parse --short HEAD)
if ! git diff --quiet || ! git diff --cached --quiet; then
    echo "警告：工作目录不干净，包名将标记为 dirty。"
    echo ""
    echo "未暂存变更:"
    git --no-pager diff --stat
    echo ""
    echo "已暂存变更:"
    git --no-pager diff --cached --stat
    echo ""
    ARCHIVE_NAME="rvnpu-dirty-${COMMIT_HASH}.tar.zst"
else
    echo "当前提交: $COMMIT_HASH（干净）"
    ARCHIVE_NAME="rvnpu-${COMMIT_HASH}.tar.zst"
fi

PACK_DIR="packed"

# 1. 清理并创建目标目录
echo "[1/7] 清理并创建 packed/ 目录..."
rm -rf "$PACK_DIR"
mkdir -p "$PACK_DIR"
mkdir -p "$PACK_DIR/workspace"

# 2. 复制根目录文件
echo "[2/7] 复制根目录文件..."
# .md 文件
if [ -f "0.依赖说明.md" ]; then
    cp "0.依赖说明.md" "$PACK_DIR/"
fi
if [ -f "README.md" ]; then
    cp "README.md" "$PACK_DIR/"
fi

# .sh 文件（排除自身 pack.sh 和将要生成的 1.init_repo.sh）
for script in *.sh; do
    if [ "$script" != "pack.sh" ] && [ "$script" != "1.init_repo.sh" ]; then
        cp "$script" "$PACK_DIR/"
    fi
done

# 3. 生成修改版的 1.init_repo.sh（跳过 git submodule）
echo "[3/7] 生成修改版 1.init_repo.sh..."
cat > "$PACK_DIR/1.init_repo.sh" << 'INIT_SCRIPT'
#!/bin/bash
echo "代码已打包在内，无需克隆子仓库。"
echo "workspace/ 目录已包含所有子仓库代码。"
mkdir -p ./workspace
INIT_SCRIPT
chmod +x "$PACK_DIR/1.init_repo.sh"

# 4. 复制 workspace 子目录（排除 .git/）
echo "[4/7] 复制 workspace 子目录..."
for subdir in workspace/*/; do
    subdir_name=$(basename "$subdir")
    if [ -d "$subdir" ]; then
        echo "  复制 $subdir_name ..."
        rsync -a --exclude='.git' "${subdir%/}" "$PACK_DIR/workspace/"
    fi
done

# 5. 运行 clean.sh 清理构建产物
echo "[5/7] 运行 clean.sh 清理构建产物..."
(cd "$PACK_DIR" && ./clean.sh)

# 6. 确保所有 .sh 文件可执行
echo "[6/7] 设置脚本可执行权限..."
chmod +x "$PACK_DIR"/*.sh 2>/dev/null || true

# 7. 多线程压缩为 .tar.zst（不包含 packed/ 层级）
echo "[7/7] 压缩为 .tar.zst（多线程）..."
tar -c -C "$PACK_DIR" . | zstd -T0 > "$ARCHIVE_NAME"

# 打印压缩包内容
echo ""
echo "压缩包内容:"
tar --zstd -tf "$ARCHIVE_NAME" | head -60
FILE_COUNT=$(tar --zstd -tf "$ARCHIVE_NAME" | wc -l)
echo "... 共 $FILE_COUNT 个文件/目录"
echo ""
echo "========================================="
echo "  打包完成！"
echo "========================================="
echo "输出目录: $PACK_DIR/"
echo "压缩包:   $ARCHIVE_NAME"
echo ""
echo "解压方式: tar --zstd -xf $ARCHIVE_NAME"
echo ""
echo "目录结构:"
find "$PACK_DIR" -maxdepth 2 -not -path '*/\.*' | sort
