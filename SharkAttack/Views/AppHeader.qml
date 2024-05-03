import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SharkAttack.Controls

Item {
    id: root
    property alias calculateButton : calculateButton
    width: 1530
    height: 200

    GridLayout{
        id: l1
        columns: 1
        visible: false
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: separator.top
        }
        LayoutItemProxy { target: appTitleLabel }
        LayoutItemProxy { target: calculateButton }
    }

    GridLayout{
        id: l2
        columns: 2
        visible: false
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: separator.top
        }
        LayoutItemProxy { target: appTitleLabel }
        LayoutItemProxy { target: calculateButton }
    }

    Rectangle {
        id: separator
        y: 190
        height: 4
        color: "#ffffff"
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            leftMargin: 0
            rightMargin: 0
            bottomMargin: 6
        }
    }


    Label {
        id: appTitleLabel
        text: qsTr("Mortgage Calculator")
        font.pixelSize: 64
    }

    Button {
        id: calculateButton
        text: qsTr("Calculate")
        font.pixelSize: 32
    }

    onWidthChanged: {
        if (width < 750) {
            l2.visible = false
            l1.visible = true
        } else {
            l1.visible = false
            l2.visible = true
        }
    }
}
