cmake_minimum_required(VERSION 3.16)

project(CtrlApp VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_PREFIX_PATH "D:/Programs/Qt/6.8.1/msvc2022_64")


find_package(Qt6 6.8 REQUIRED COMPONENTS Quick SerialPort)

qt_standard_project_setup(REQUIRES 6.8)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

qt_add_executable(appCtrlApp
    main.cpp
)

qt_add_qml_module(appCtrlApp
    URI CtrlApp
    VERSION 1.0
    QML_FILES Main.qml OpPage.qml LoginPage.qml CtrlBtn.qml
    SOURCES serialport.h serialport.cpp
    SOURCES portcontroller.h portcontroller.cpp
    RESOURCES resource.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appCtrlApp PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appCtrlApp
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appCtrlApp
    PRIVATE Qt6::Quick Qt6::SerialPort
)

include(GNUInstallDirs)
install(TARGETS appCtrlApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)

# get_target_property(qmake_exec_filepath Qt6::qmake IMPORTED_LOCATION)
# get_filename_component(qt_exec_bin_dir "${qmake_exec_filepath}" DIRECTORY)
# find_program(windeployqt_exec_filepath windeployqt HINTS "${qt_exec_bin_dir}")
# add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
#        COMMAND "${CMAKE_COMMAND}" -E
#        env PATH="${qt_exec_bin_dir}" "${windeployqt_exec_filepath}"
#        "$<TARGET_FILE:${PROJECT_NAME}>" -qmldir "${qt_exec_bin_dir}/../qml"
#        COMMENT "Running windeployqt..."
#        )
