include(GNUInstallDirs)

if(GLDIAGRAM_BUILD_APP)
    install(TARGETS GLDiagram
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        BUNDLE DESTINATION .
    )
endif()
