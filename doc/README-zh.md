# GLDiagram 中文说明

GLDiagram 是一个 C11 OpenGL 3.3 绘图画布应用，集成 Nuklear 即时模式
GUI。本仓库已按本地 `c-project-standard` 模板整理：模块化 CMake、CMake
presets、CTest、检查脚本、CI 和简短维护文档。

## 快速开始

```sh
cmake --preset debug
cmake --build --preset debug
ctest --preset debug --output-on-failure
```

运行程序：

```sh
./build/debug/bin/GLDiagram
```

Windows PowerShell：

```powershell
./scripts/check.ps1
.\build\debug\bin\GLDiagram.exe
```

## 目录结构

```text
include/        项目头文件和 vendored 头文件
src/            应用源码和隔离的第三方实现编译单元
tests/          CTest 测试
cmake/          CMake 模块
scripts/        本地检查脚本
doc/            维护文档
doc/guides/     专题指南
.github/        CI、Issue 和 PR 模板
```

项目自有公开头文件放在 `include/gldiagram/`。GLAD、KHR 和 Nuklear 保留各自
上游 include 命名空间。

## 依赖

- GLFW 3.3.9 通过 CMake `FetchContent` 获取。
- OpenGL 通过 `find_package(OpenGL REQUIRED)` 查找。
- GLAD 和 Nuklear 作为源码/头文件随仓库维护。

Linux 构建需要 OpenGL 与 X11 开发包，详见
[doc/guides/environment.md](doc/guides/environment.md)。

更多说明见 [doc/README.md](doc/README.md) 和
[doc/cmake-guide.md](doc/cmake-guide.md)。
