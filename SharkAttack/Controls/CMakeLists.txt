cmake_minimum_required(VERSION 3.23)

project(Controls
    VERSION 1.0
    LANGUAGES CXX
    DESCRIPTION "SharkAttack - Controls"
)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick Gui QuickControls2)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTORCC ON)

set(SINGLETON_QML_FILES
    #Add singleton Qml files here
    Theme.qml
)

set_source_files_properties(
    ${SINGLETON_QML_FILES}
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)


qt_add_qml_module(controlsModule
    URI SharkAttack.Controls
    VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    STATIC
    IMPORTS
        #For all other controls we don't customize here, we fall back to these
        QtQuick.Controls.Material
    QML_FILES
        ${SINGLETON_QML_FILES}
        ApplicationWindow.qml
        Pane.qml
        Label.qml
        Switch.qml
        ToolBar.qml
        Button.qml
    SOURCES
        SystemTheme.h
        SystemTheme.cpp
)

target_link_libraries(controlsModule
    PRIVATE
        Qt6::Quick
        Qt6::Gui
        Qt6::QuickControls2
)
