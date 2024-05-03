import QtQuick
import QtQuick.Templates as T
import SharkAttack.Controls

T.Pane {
    id: pane
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: Theme.spacingSmall

    background: Rectangle{
        color: SystemTheme.popupColor
        radius: 90

        Behavior on color {
            ColorAnimation {
                duration: 150
            }
        }
    }
}
