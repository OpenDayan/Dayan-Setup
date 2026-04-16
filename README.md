# RVT 张量指令测试及模拟器集成工程

本项目用于构建和运行 RVT 张量指令的测试环境及模拟器，支持完整的编译构建和调试流程。

## 项目结构

```
├── 0.依赖说明.md           # 依赖环境安装说明
├── 1.setup_test.sh         # 编译张量指令测试程序
├── 2.compile_kernels.sh    # 编译 RVT 仿真器 (rvtng-cmodel)
├── 3.compile_emu.sh        # 编译仿真器运行时环境
├── 4.compile_qemu.sh       # 编译 QEMU 模拟器
├── 5.compile_firmware.sh   # 编译 NPU 固件 (bootrom)
├── 6.0.run_emu.sh          # 启动仿真器
├── 6.1.run_gdb.sh          # 启动 GDB 调试
└── bin/                    # 编译产物输出目录
```

## 环境准备

在开始编译之前，请按照 `0.依赖说明.md` 安装所需的依赖。

## 编译构建

完成依赖安装后，按顺序执行 1-5 的脚本，完成子仓库初始化和编译。

## 运行与调试

编译完成后，可以使用以下脚本运行和调试：

### 启动仿真器
```bash
./6.0.run_emu.sh
```

启动 RVT 仿真器和 QEMU，加载测试程序。仿真器会监听 GDB 调试端口（默认 1234）。

### 启动 GDB 调试
```bash
./6.1.run_gdb.sh
```

使用 gdb-multiarch 连接到运行中的仿真器进行远程调试。
默认会在 `test_elem_add_fp32_kernel` 函数处设置断点并启动执行。

## 工作空间说明

所有待编译的项目通过 Git Submodule 管理，位于 `workspace/` 目录：
- `workspace/npu-kernels` - 张量指令测试程序
- `workspace/rvtng-cmodel` - RVT 仿真器
- `workspace/npu-qemu` - QEMU 模拟器
- `workspace/npu-firmware` - NPU 固件

## 注意事项

1. 确保所有 submodule 已正确初始化和更新：
   ```bash
   git submodule update --init --recursive
   ```

2. 编译过程中产生的中间文件和最终产物均会收集到 `bin/` 目录，便于管理和使用。

3. 调试时，仿真器需要先启动（`./6.0.run_emu.sh`），然后再运行 GDB（`./6.1.run_gdb.sh`）。
