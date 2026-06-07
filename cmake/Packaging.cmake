include(GNUInstallDirs)

if(TARGET GLDiagram)
    install(TARGETS GLDiagram
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        BUNDLE DESTINATION .
    )
endif()
