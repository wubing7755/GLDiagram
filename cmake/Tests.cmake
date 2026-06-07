function(gldiagram_add_test target)
    cmake_parse_arguments(GLDIAGRAM_TEST
        ""
        ""
        "SOURCES;LIBS"
        ${ARGN}
    )

    if(NOT GLDIAGRAM_TEST_SOURCES)
        message(FATAL_ERROR "gldiagram_add_test(${target}) requires SOURCES")
    endif()

    add_executable(${target}
        ${GLDIAGRAM_TEST_SOURCES}
    )

    target_include_directories(${target}
        PRIVATE
            "${CMAKE_CURRENT_SOURCE_DIR}/include"
            "${GLDIAGRAM_GENERATED_INCLUDE_DIR}"
    )

    if(GLDIAGRAM_TEST_LIBS)
        target_link_libraries(${target} PRIVATE ${GLDIAGRAM_TEST_LIBS})
    endif()

    gldiagram_target_defaults(${target})
    gldiagram_set_runtime_output(${target})

    add_test(NAME ${target} COMMAND $<TARGET_FILE:${target}>)
    list(APPEND GLDIAGRAM_TEST_TARGETS ${target})
    set(GLDIAGRAM_TEST_TARGETS "${GLDIAGRAM_TEST_TARGETS}" PARENT_SCOPE)
endfunction()

gldiagram_add_test(gldiagram_version_tests
    SOURCES
        ${CMAKE_CURRENT_SOURCE_DIR}/tests/test_version.c
)

add_custom_target(gldiagram_tests
    DEPENDS
        ${GLDIAGRAM_TEST_TARGETS}
)
