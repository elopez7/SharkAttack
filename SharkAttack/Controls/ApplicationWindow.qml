import QtQuick
import QtQuick.Templates as T
import SharkAttack.Controls

T.ApplicationWindow {
    id: window

    color: SystemTheme.windowColor

    Behavior on color{

        ColorAnimation {
            duration: 150
        }
    }
}
