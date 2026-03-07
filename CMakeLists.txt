cmake_minimum_required(VERSION 3.10)

project(GLDiagram
    VERSION 1.0.0
    DESCRIPTION "OpenGL Drawing Canvas"
    LANGUAGES C
)

# ---------- C 标准 ----------
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# ---------- 输出目录 ----------
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# ---------- FetchContent ----------
include(FetchContent)

# ---------- 下载 GLFW ----------
FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG 3.3.9
)

FetchContent_MakeAvailable(glfw)

# ---------- 查找 OpenGL ----------
find_package(OpenGL REQUIRED)

# ---------- 源文件 ----------
set(SOURCES
    src/main.c
    src/glad.c
)

# ---------- 可执行文件 ----------
add_executable(${PROJECT_NAME} ${SOURCES})

# ---------- 头文件目录 ----------
target_include_directories(${PROJECT_NAME} PRIVATE
    include
)

# ---------- 链接库 ----------
target_link_libraries(${PROJECT_NAME} PRIVATE
    glfw
    OpenGL::GL
)

# ---------- Windows 额外库 ----------
if(WIN32)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        gdi32
    )
endif()

# ---------- Linux ----------
if(UNIX AND NOT APPLE)
    target_link_libraries(${PROJECT_NAME} PRIVATE
        pthread
        dl
    )
endif()

# ---------- 构建信息 ----------
message(STATUS "----------------------------------")
message(STATUS "Project: ${PROJECT_NAME}")
message(STATUS "Version: ${PROJECT_VERSION}")
message(STATUS "System: ${CMAKE_SYSTEM_NAME}")
message(STATUS "Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "----------------------------------")