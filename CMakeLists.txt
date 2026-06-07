cmake_minimum_required(VERSION 3.20)

project(GLDiagram
    VERSION 1.0.0
    DESCRIPTION "OpenGL 3.3 drawing canvas with Nuklear immediate-mode GUI"
    LANGUAGES C
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

if(CMAKE_SOURCE_DIR STREQUAL PROJECT_SOURCE_DIR)
    set(GLDIAGRAM_IS_TOP_LEVEL_DEFAULT ON)
else()
    set(GLDIAGRAM_IS_TOP_LEVEL_DEFAULT OFF)
endif()

if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Build type" FORCE)
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
        "Debug" "Release" "RelWithDebInfo" "MinSizeRel")
endif()

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)

option(GLDIAGRAM_ENABLE_ASAN "Enable AddressSanitizer where supported" OFF)
option(GLDIAGRAM_ENABLE_UBSAN "Enable UndefinedBehaviorSanitizer where supported" OFF)
option(GLDIAGRAM_ENABLE_COVERAGE "Enable coverage flags where supported" OFF)
option(GLDIAGRAM_BUILD_APP "Build the GLDiagram application" ${GLDIAGRAM_IS_TOP_LEVEL_DEFAULT})
option(GLDIAGRAM_BUILD_TESTING "Build CTest tests" ${GLDIAGRAM_IS_TOP_LEVEL_DEFAULT})
option(GLDIAGRAM_INSTALL "Generate install rules" ${GLDIAGRAM_IS_TOP_LEVEL_DEFAULT})

set(GLDIAGRAM_GENERATED_INCLUDE_DIR "${CMAKE_CURRENT_BINARY_DIR}/generated/include")
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/gldiagram_version.h.in"
    "${GLDIAGRAM_GENERATED_INCLUDE_DIR}/gldiagram/version.h"
    @ONLY
)

include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/CompilerOptions.cmake")
include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/Dependencies.cmake")
include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/Sources.cmake")

add_library(gldiagram_vendor OBJECT ${GLDIAGRAM_VENDOR_SOURCES})
target_compile_features(gldiagram_vendor PRIVATE c_std_11)
target_compile_definitions(gldiagram_vendor PRIVATE GLFW_INCLUDE_NONE)
target_include_directories(gldiagram_vendor
    PRIVATE
        "${GLDIAGRAM_GENERATED_INCLUDE_DIR}"
)
target_include_directories(gldiagram_vendor
    SYSTEM PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/include"
        "${glfw_SOURCE_DIR}/include"
)
set_target_properties(gldiagram_vendor PROPERTIES
    POSITION_INDEPENDENT_CODE ON
)

if(GLDIAGRAM_BUILD_APP)
    add_executable(GLDiagram
        ${GLDIAGRAM_APP_SOURCES}
        $<TARGET_OBJECTS:gldiagram_vendor>
    )

    target_compile_definitions(GLDiagram PRIVATE GLFW_INCLUDE_NONE)
    target_include_directories(GLDiagram
        PRIVATE
            "${GLDIAGRAM_GENERATED_INCLUDE_DIR}"
    )
    target_include_directories(GLDiagram
        SYSTEM PRIVATE
            "${CMAKE_CURRENT_SOURCE_DIR}/include"
            "${glfw_SOURCE_DIR}/include"
    )
    target_link_libraries(GLDiagram
        PRIVATE
            glfw
            OpenGL::GL
    )
    if(WIN32)
        target_link_libraries(GLDiagram PRIVATE gdi32)
    endif()
    if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
        target_link_libraries(GLDiagram PRIVATE dl pthread)
    endif()

    gldiagram_target_defaults(GLDiagram)
    gldiagram_set_runtime_output(GLDiagram)
endif()

if(GLDIAGRAM_BUILD_TESTING)
    enable_testing()
    include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/Tests.cmake")
endif()

if(GLDIAGRAM_INSTALL)
    include("${CMAKE_CURRENT_SOURCE_DIR}/cmake/Packaging.cmake")
endif()

message(STATUS "----------------------------------")
message(STATUS "Project: ${PROJECT_NAME}")
message(STATUS "Version: ${PROJECT_VERSION}")
message(STATUS "System: ${CMAKE_SYSTEM_NAME}")
message(STATUS "Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "----------------------------------")
