import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtCharts
import SharkAttack.Controls

Item {
    id: root
    property alias principalPercentage: principalSlice.value
    property alias interestPercentage: interestSlice.value
    property real totalAmountValue
    property real principalValue
    property real interestValue

    width: 770
    height: 500

    ColumnLayout{
        anchors.fill: parent
        Label {
            id: paymentBreakdownLabel
            text: qsTr("Monthly Payment Breakdown")
            wrapMode: Text.WordWrap
            font: Theme.desktopTitleFontObject
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.minimumHeight: 160
            Layout.minimumWidth: 160
            ChartView {
                id: pie
                backgroundColor: SystemTheme.popupColor
                anchors.fill: parent
                legend.labelColor: totalAmount.color
                PieSeries {
                    id: pieSeries
                    name: "Monthly Payment"
                    PieSlice {
                        id: principalSlice
                        value: 50.0
                        label: qsTr("Principal: $" + principalValue.toFixed(2))
                        labelPosition: PieSlice.LabelOutside
                        labelVisible: true
                        labelColor: totalAmount.color
                    }

                    PieSlice {
                        id: interestSlice
                        value: 50.0
                        label: qsTr("Interest: $"+interestValue.toFixed(2))
                        labelPosition: PieSlice.LabelOutside
                        labelVisible: true
                        labelColor: totalAmount.color
                    }
                }
                Behavior on backgroundColor {
                    ColorAnimation {
                        duration: 150
                    }
                }
            }
        }
        Label {
            id: totalAmount
            text: qsTr("Total: $" + totalAmountValue.toFixed(2))
            Layout.fillWidth: true
            Layout.bottomMargin: 32
            font: Theme.desktopSubtitleFontObject
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    states:[
        State {
            name: "desktopLayout"
            when: Theme.isBigDesktopLayout
            PropertyChanges {
                target: paymentBreakdownLabel
                font: Theme.desktopTitleFontObject
            }
            PropertyChanges{
                target: totalAmount
                font: Theme.desktopTitleFontObject
            }
        },
        State {
            name: "smallDesktopLayout"
            when: Theme.isSmallDesktopLayout
            PropertyChanges {
                target: paymentBreakdownLabel
                font: Theme.desktopSubtitleFontObject
            }
            PropertyChanges{
                target: totalAmount
                font: Theme.desktopSubtitleFontObject
            }
        },
        State{
            name: "mobileLayout"
            when: Theme.isMobileLayout
            PropertyChanges {
                target: paymentBreakdownLabel
                font: Theme.mobileTitleFontObject
            }
            PropertyChanges{
                target: totalAmount
                font: Theme.mobileTitleFontObject
            }
        },
        State{
            name: "smallLayout"
            when: Theme.isSmallLayout
            PropertyChanges{
                target: paymentBreakdownLabel
                font: Theme.smallTitleFontObject
            }
            PropertyChanges{
                target: totalAmount
                font: Theme.smallTitleFontObject
            }
        }
    ]
}
