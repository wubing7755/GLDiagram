GLDiagram
=========

基于 OpenGL 3.3 的绘图画布，集成了 Nuklear 即时模式 GUI。
一个极简的 OpenGL + GUI 应用起步模板。



目录:

    I.   概述
    II.  快速开始
    III. 环境要求
    IV.  编译构建
    V.   项目结构
    VI.  定制开发
    VII. 依赖说明
    VIII.许可证



I.   概述

     GLDiagram 是一个极简的 OpenGL 3.3 项目模板，集成了 Nuklear
     即时模式 GUI。演示内容:

        - 使用 GLFW 和 GLAD 建立 OpenGL 3.3 Core Profile
        - Nuklear GUI 的初始化和渲染循环
        - 正确的资源管理与清理
        - 跨平台构建 (Windows, Linux, macOS)

     可作为 OpenGL 应用程序的起点，快速添加轻量级、可移植的 GUI。



II.  快速开始

     $ git clone <仓库URL>
     $ cd GLDiagram
     $ mkdir build && cd build
     $ cmake ..
     $ cmake --build .
     $ ./bin/GLDiagram          # Linux / macOS
     $ ./bin/GLDiagram.exe      # Windows



III. 环境要求

     - CMake 3.10 或更高
     - C11 兼容的编译器
     - 支持 OpenGL 3.3 的显卡驱动

     Windows:
         MinGW-w64 或支持 CMake 的 Visual Studio
         MSYS2: pacman -S mingw-w64-ucrt-x86_64-gcc cmake

     Linux:
         GCC/Clang + X11 开发文件
         apt install build-essential cmake libgl1-mesa-dev \
                     libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev

     macOS:
         Xcode 命令行工具
         brew install cmake



IV.  编译构建

     项目使用 CMake FetchContent 自动下载依赖，无需手动安装。

     $ mkdir build && cd build
     $ cmake -G "Unix Makefiles" ..     # Linux / macOS
     $ cmake -G "MinGW Makefiles" ..    # Windows (MSYS2/MinGW)
     $ cmake -G "Visual Studio ..." ..  # Windows (Visual Studio)

     $ cmake --build .

     编译产物输出到 build/bin/ 目录。



V.   项目结构

     GLDiagram/
     |
     +- CMakeLists.txt          CMake 构建配置
     +- LICENSE.txt              MIT 许可证
     +- README.md                英文说明文档
     +- README-zh.md             中文说明文档
     +- .gitignore               Git 忽略文件配置
     +- .gitattributes           Git 文件属性
     |
     +-.github/
     |  +- workflows/
     |     +- build.yml          GitHub Actions CI 配置
     |
     +- src/
     |  +- main.c                程序入口
     |  +- glad.c                OpenGL 函数加载器（已在 git 中）
     |
     +- include/
     |  +- glad/
     |  |  +- glad.h             GLAD 头文件（已在 git 中）
     |  +- nuklear/
     |     +- nuklear_glfw_gl3.h Nuklear GLFW 后端（已在 git 中）
     |     +- nuklear.h          Nuklear 核心（通过 FetchContent 下载）
     |
     +- build/                   编译输出目录 (CMake 自动创建)



VI.  定制开发

     修改 src/main.c 添加你的渲染和 UI 代码。

     主循环示例:

         glfwPollEvents();
         nk_glfw3_new_frame(&glfw_ctx);

         if (nk_begin(ctx, "窗口标题", ...)) {
             // 在此添加你的 UI 代码
             nk_button_label(ctx, "点击我");
         }
         nk_end(ctx);

         glClear(GL_COLOR_BUFFER_BIT);
         nk_glfw3_render(&glfw_ctx, NK_ANTI_ALIASING_ON, ...);
         glfwSwapBuffers(window);

     Nuklear API 文档: https://github.com/Immediate-Mode-UI/Nuklear



VII. 依赖说明

     GLFW       3.3.9    https://www.glfw.org/         zlib
     Nuklear    latest   https://github.com/Immediate-Mode-UI/Nuklear  MIT
     GLAD       0.1.36   https://github.com/Dav1dde/glad  MIT

     GLFW 和 Nuklear 通过 CMake FetchContent 在配置阶段自动下载。
     GLAD 已包含在 git 仓库中（重新生成: pip install glad && glad
     --generator=c --profile=core --api=gl:3.3 --out-path=include/glad/）。



VIII. 许可证

     MIT License，详见 LICENSE.txt。
