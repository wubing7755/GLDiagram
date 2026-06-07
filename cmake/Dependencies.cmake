include(FetchContent)

set(GLFW_BUILD_EXAMPLES OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_TESTS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_DOCS OFF CACHE BOOL "" FORCE)
set(GLFW_BUILD_FOR_DISTRO OFF CACHE BOOL "" FORCE)
set(GLFW_INSTALL OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
    glfw
    GIT_REPOSITORY https://github.com/glfw/glfw.git
    GIT_TAG 3.3.9
)

FetchContent_MakeAvailable(glfw)

find_package(OpenGL REQUIRED)

if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/src/glad.c"
        OR NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/include/glad/glad.h")
    message(FATAL_ERROR "GLAD files not found. Regenerate with: glad --generator=c --profile=core --api=gl:3.3 --out-path=include/glad/")
endif()

if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/include/KHR/khrplatform.h")
    file(MAKE_DIRECTORY "${GLDIAGRAM_GENERATED_INCLUDE_DIR}/KHR")
    file(COPY "${glfw_SOURCE_DIR}/deps/glad/khrplatform.h"
        DESTINATION "${GLDIAGRAM_GENERATED_INCLUDE_DIR}/KHR")
endif()
