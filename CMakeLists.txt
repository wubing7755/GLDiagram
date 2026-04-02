cmake_minimum_required(VERSION 3.10)

project(GLDiagram
    VERSION 1.0.0
    DESCRIPTION "OpenGL Drawing Canvas"
    LANGUAGES C
)

# ---------- 测试 ----------
include(CTest)

# ---------- C 标准 ----------
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

# ---------- 输出目录 ----------
# 对于 Visual Studio 多配置生成器，需要设置 CMAKE_CONFIGURATION_TYPES
if(CMAKE_CONFIGURATION_TYPES)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_BINARY_DIR}/bin)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_BINARY_DIR}/bin)
else()
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
endif()

# ---------- FetchContent ----------
include(FetchContent)

# ---------- 下载 GLFW ----------
set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_FOR_DISTRO OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG 3.3.9
)

# ---------- 下载 Nuklear ----------
FetchContent_Declare(
    nuklear
    GIT_REPOSITORY https://github.com/Immediate-Mode-UI/Nuklear.git
)

FetchContent_MakeAvailable(glfw nuklear)

# ---------- 查找 OpenGL ----------
find_package(OpenGL REQUIRED)

# ---------- GLAD ----------
# glad.c 不在版本控制中，需要通过 glad 工具生成
# 生成命令: pip install glad && glad --generator=c --profile=core --api=gl:3.3 --out-path=include/glad/
# 或访问 https://glad.dav1d.de/ 在线生成
if(NOT EXISTS ${CMAKE_SOURCE_DIR}/src/glad.c OR NOT EXISTS ${CMAKE_SOURCE_DIR}/include/glad/glad.h)
    message(FATAL_ERROR "glad files not found.\n"
        "Run the following commands to generate:\n"
        "  pip install glad\n"
        "  glad --generator=c --profile=core --api=gl:3.3 --out-path=include/glad/\n"
    )
endif()

# ---------- 源文件 ----------
set(SOURCES
    src/main.c
    src/glad.c
)

# ---------- 可执行文件 ----------
add_executable(${PROJECT_NAME} ${SOURCES})

# ---------- 头文件目录 ----------
# GLFW/Nuklear from FetchContent, glad/KHR from local
target_include_directories(${PROJECT_NAME} PRIVATE
    ${glfw_SOURCE_DIR}/include
    ${nuklear_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/include
)

# ---------- KHR Headers ----------
# Copy KHR headers from GLFW deps if not present
if(NOT EXISTS ${CMAKE_SOURCE_DIR}/include/KHR/khrplatform.h)
    file(COPY ${glfw_SOURCE_DIR}/deps/glad/khrplatform.h
         DESTINATION ${CMAKE_SOURCE_DIR}/include/KHR/)
endif()

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

# ---------- Unix (Linux/macOS) ----------
if(UNIX)
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

# ---------- 测试 ----------
# 注意: OpenGL 程序需要图形环境才能运行
# 此测试仅验证可执行文件已成功构建，不实际运行程序
if(BUILD_TESTING)
    add_test(NAME VerifyBuild COMMAND bash -c "test -f ${CMAKE_BINARY_DIR}/bin/${PROJECT_NAME}.exe")
endif()