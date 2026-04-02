GLDiagram
=========

An OpenGL drawing canvas with Nuklear immediate-mode GUI.
A minimal starter template for OpenGL 3.3 + GUI applications.



Contents:

    I.   OVERVIEW
    II.  QUICK START
    III. REQUIREMENTS
    IV.  BUILDING
    V.   PROJECT STRUCTURE
    VI.  CUSTOMIZING
    VII. DEPENDENCIES
    VIII.LICENSE



I.   OVERVIEW

     GLDiagram is a minimal OpenGL 3.3 project template with Nuklear
     immediate-mode GUI integration. It demonstrates:

        - OpenGL 3.3 Core Profile setup with GLFW and GLAD
        - Nuklear GUI initialization and rendering loop
        - Proper resource management and cleanup
        - Cross-platform build (Windows, Linux, macOS)

     Use this as a starting point for OpenGL applications that need
     a lightweight, portable GUI.



II.  QUICK START

     $ git clone <repository-url>
     $ cd GLDiagram
     $ mkdir build && cd build
     $ cmake ..
     $ cmake --build .
     $ ./bin/GLDiagram          # Linux/macOS
     $ ./bin/GLDiagram.exe      # Windows



III. REQUIREMENTS

     - CMake 3.10 or higher
     - C11-compatible compiler
     - OpenGL 3.3 capable graphics driver

     Windows:
         MinGW-w64 or Visual Studio with CMake support
         MSYS2: pacman -S mingw-w64-ucrt-x86_64-gcc cmake

     Linux:
         GCC/Clang + X11 dev files
         apt install build-essential cmake libgl1-mesa-dev \
                     libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev

     macOS:
         Xcode command line tools
         brew install cmake



IV.  BUILDING

     The project uses CMake with FetchContent to download dependencies.

     $ mkdir build && cd build
     $ cmake -G "Unix Makefiles" ..     # Linux/macOS
     $ cmake -G "MinGW Makefiles" ..    # Windows (MSYS2/MinGW)
     $ cmake -G "Visual Studio ..." ..  # Windows (Visual Studio)

     $ cmake --build .

     Build output goes to build/bin/.

     Testing (optional):
     $ cmake -DBUILD_TESTING=ON ..
     $ cmake --build .
     $ ctest --output-on-failure



V.   PROJECT STRUCTURE

     GLDiagram/
     |
     +- CMakeLists.txt          Build configuration
     +- LICENSE.txt              MIT License
     +- README.md                This file
     +- .gitignore               Git ignore patterns
     +- .gitattributes           Git file attributes
     |
     +-.github/
     |  +- workflows/
     |     +- build.yml          GitHub Actions CI
     |
     +- src/
     |  +- main.c                Application entry point
     |  +- glad.c                OpenGL function loader (in git)
     |
     +- include/
     |  +- glad/
     |  |  +- glad.h             GLAD header (in git)
     |  +- nuklear/
     |     +- nuklear_glfw_gl3.h Nuklear GLFW backend (in git)
     |     +- nuklear.h          Nuklear core (via FetchContent)
     |
     +- build/                   Build output (created by CMake)



VI.  CUSTOMIZING

     Modify src/main.c to add your own rendering and UI code.

     The main loop demonstrates:

         glfwPollEvents();
         nk_glfw3_new_frame(&glfw_ctx);

         if (nk_begin(ctx, "Window Title", ...)) {
             // Your UI code here
             nk_button_label(ctx, "Click Me");
         }
         nk_end(ctx);

         glClear(GL_COLOR_BUFFER_BIT);
         nk_glfw3_render(&glfw_ctx, NK_ANTI_ALIASING_ON, ...);
         glfwSwapBuffers(window);

     See https://github.com/Immediate-Mode-UI/Nuklear for Nuklear API
     documentation.



VII. DEPENDENCIES

     GLFW       3.3.9    https://www.glfw.org/         zlib
     Nuklear    latest   https://github.com/Immediate-Mode-UI/Nuklear  MIT
     GLAD       0.1.36   https://github.com/Dav1dde/glad  MIT

     GLFW and Nuklear are downloaded automatically via CMake
     FetchContent at configure time. GLAD is included in the git
     repository (regenerate via: pip install glad && glad --generator=c
     --profile=core --api=gl:3.3 --out-path=include/glad/).



VIII. LICENSE

     MIT License. See LICENSE.txt for full text.
