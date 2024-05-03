cmake_minimum_required(VERSION 3.23)

project(Views
    VERSION 1.0
    LANGUAGES CXX
    DESCRIPTION "SharkAttack - Views"
)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

set(SINGLETON_QML_FILES
    # add QML Singleton files here
)

set_source_files_properties(
    # this trick conveniently sets the flag on all the files for qmldir generation
    ${SINGLETON_QML_FILES}
    PROPERTIES
        QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(viewsModule
    URI SharkAttack.Views
    VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    STATIC
    QML_FILES
        ${SINGLETON_QML_FILES}
        InputView.qml
        PaymentView.qml
        AppHeader.qml
    SOURCES
)

target_link_libraries(viewsModule
    PRIVATE
        Qt6::Quick
)
