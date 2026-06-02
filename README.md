# RVT 张量指令测试及模拟器与 llama.cpp 集成工程

本项目用于构建和运行 RVT 张量指令的测试环境及模拟器，支持完整的编译构建和调试流程。

## 项目结构

```
├── 0.依赖说明.md             # 依赖环境安装说明
├── 1.init_repo.sh           # 初始化 workspace 子仓库
├── 2.compile_kernels.sh     # 编译张量指令测试程序
├── 3.compile_emu.sh         # 编译 RVT 仿真器 (rvtng-cmodel)
├── 4.compile_qemu.sh        # 编译 QEMU 模拟器
├── 5.compile_firmware.sh    # 编译 NPU 固件 (bootrom)
├── 6.0.run_emu_noruntime.sh # 启动仿真器(无运行时模式)
├── 6.0.run_emu.sh           # 启动仿真器
├── 6.1.run_gdb_noruntime.sh # 启动 GDB 调试(无运行时模式)
├── 6.1.run_gdb.sh           # 启动 GDB 调试
├── 7.compile_llama.cpp.sh   # 构建 llama.cpp 大模型推理框架
├── 8.0.run_emu.sh           # 启动仿真器(不等待调试器挂载)
├── 8.1.run_llama.cpp.sh     # 启动 llama.cpp 大模型推理框架
└── bin/                     # 编译产物输出目录
```

## 环境准备

在开始编译之前，请按照 `0.依赖说明.md` 安装所需的依赖。

## 编译构建

完成依赖安装后，按顺序执行编号为 1 至 5 的脚本，完成子仓库初始化和编译。

## 张量指令测试程序运行与调试

编译完成后，可以使用以下脚本运行和调试示例指令测试：

### 启动仿真器
```bash
./6.0.run_emu_noruntime.sh
```

启动 RVT 仿真器和 QEMU，加载测试程序。仿真器会监听 GDB 调试端口（默认 1234）。

### 启动 GDB 调试
```bash
./6.1.run_gdb.sh
```

使用 gdb-multiarch 连接到运行中的仿真器进行远程调试。
默认会在 `kernel_add_fp32` 函数处设置断点并启动执行。

## 大模型推理示例运行

执行编号为 7 的脚本，完成 llama.cpp 推理框架的编译。编译完成后，可以使用编号为 8.0 的脚本启动 RVT 仿真器和 QEMU。仿真器被配置为不监听 GDB 调试端口。

等待模拟器启动后，可以使用编号为 8.1 的脚本启动 llama.cpp 大模型推理用例。

## 工作空间说明

所有待编译的项目均位于 `workspace/` 目录：
- `workspace/npu-kernels` - 张量指令测试程序
- `workspace/rvtng-cmodel` - RVT 仿真器
- `workspace/npu-qemu` - QEMU 模拟器
- `workspace/npu-firmware` - NPU 固件
- `workspace/llama.cpp` - llama.cpp 大模型推理框架
- `workspace/npu-runtime` - NPU 运行时框架

## 注意事项

1. 确保所有 submodule 已正确初始化和更新：
   ```bash
   git submodule update --init --recursive
   ```

2. 编译过程中产生的中间文件和最终产物均会收集到 `bin/` 目录，便于管理和使用。

3. 调试时，仿真器需要先启动（`./6.0.run_emu_noruntime.sh`），然后再运行 GDB（`./6.1.run_gdb.sh`）。
