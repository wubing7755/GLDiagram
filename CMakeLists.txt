cmake_minimum_required(VERSION 3.15)
project(GLD_RUN)

# 1. 设置C++标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 2. 定义项目结构
set(HEAD_DIR ${CMAKE_SOURCE_DIR}/heads)
set(LIBS_DIR ${CMAKE_SOURCE_DIR}/libs)

# 3. 先创建可执行目标
add_executable(${PROJECT_NAME}
    src/main.cpp        # 主程序入口
    glad/glad.c          # GLAD 实现文件
)

# 4. 添加头文件搜索路径
target_include_directories(${PROJECT_NAME} PUBLIC
    ${HEAD_DIR}
    ${HEAD_DIR}/glad
    ${HEAD_DIR}/GLFW
    ${HEAD_DIR}/KHR
)

# 5. 链接库文件
target_link_directories(${PROJECT_NAME} PRIVATE ${LIBS_DIR})
target_link_libraries(${PROJECT_NAME}
    glfw3           # 链接 glfw3.lib
    opengl32        # Windows 需要链接 opengl32.lib
)
