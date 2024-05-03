cmake_minimum_required(VERSION 3.23)

project(SharkAttack
    VERSION 0.1
    LANGUAGES CXX
    DESCRIPTION "SharkAttack - Best Practices version"
)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Widgets Charts)

qt_standard_project_setup(REQUIRES 6.5)

# (Some of these are turned on by qt_standard_project_setup)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_compile_definitions(
    QT_USE_FAST_CONCATENATION
    QT_NO_URL_CAST_FROM_STRING
    QT_NO_CAST_TO_ASCII
    QT_NO_CAST_FROM_ASCII
    QT_NO_NARROWING_CONVERSIONS_IN_CONNECT
    QT_NO_FOREACH
    QT_USE_QSTRINGBUILDER
    QT_DISABLE_DEPRECATED_BEFORE=0x0603ff
    $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>
)

qt_add_executable(appSharkAttack
    main.cpp
)

set(SINGLETON_QML_FILES
    #Add Qml Singleton files here
)

set_source_files_properties(
    #This trick conveniently sets the flag on all the files for qmlfir generation
    ${SINGLETON_QML_FILES}
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(appSharkAttack
    URI SharkAttack
    VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    QML_FILES
        ${SINGLETON_QML_FILES}
        Main.qml
)

add_subdirectory(SharkAttack/Controls/)
add_subdirectory(SharkAttack/Views/)
add_subdirectory(SharkAttack/Resources/)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appSharkAttack PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appSharkAttack
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appSharkAttack
    PRIVATE
    Qt6::Quick
    Qt6::Widgets
    Qt6::Charts
    viewsModuleplugin
    controlsModuleplugin
)

include(GNUInstallDirs)
install(TARGETS appSharkAttack
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
