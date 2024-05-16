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
            font.pixelSize: 48
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true

            RowLayout{
                id:chartLayout
                anchors.fill: parent
                ChartView {
                    id: pie
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    legend.visible: false
                    backgroundColor: SystemTheme.popupColor
                    PieSeries {
                        name: "Monthly Payment"
                        holeSize: 0.5
                        PieSlice {
                            id: principalSlice
                            value: 13.5
                            label: "Principal"
                        }

                        PieSlice {
                            id: interestSlice
                            value: 10.9
                            label: "Interest"
                        }
                    }

                    Label {
                        id: totalAmount
                        text: qsTr("$" + totalAmountValue.toFixed(2))
                        anchors.fill: parent
                        font: Theme.desktopSubtitleFontObject
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    Behavior on backgroundColor {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }
                Item{
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    GridLayout{
                        anchors.fill: parent
                        anchors.topMargin: 64
                        anchors.bottomMargin: 256
                        rows: 2
                        columns: 3
                        Rectangle {
                            id: legendPrincipalShape
                            color: "#092d40"
                            radius: 20
                            Layout.minimumHeight: 32
                            Layout.minimumWidth: 32
                        }

                        Label {
                            id: principalLabel
                            text: qsTr("Principal")
                            font: Theme.desktopSubtitleFontObject
                        }

                        Label {
                            id: principalAmountLabel
                            text: qsTr("$" + principalValue.toFixed(2))
                            font: Theme.desktopSubtitleFontObject
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignBottom
                        }
                        Rectangle {
                            id: legendInterestShape
                            color: "#209fdf"
                            radius: 20
                            Layout.minimumHeight: 32
                            Layout.minimumWidth: 32
                        }

                        Label {
                            id: interestLabel
                            text: qsTr("Interest")
                            font: Theme.mobileTitleFontObject
                        }

                        Label {
                            id: interestAmountLabel
                            text: qsTr("$"+interestValue.toFixed(2))
                            font: Theme.desktopSubtitleFontObject
                            horizontalAlignment: Text.AlignRight
                            verticalAlignment: Text.AlignBottom
                        }
                    }
                }
            }

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
            PropertyChanges {
                target: principalLabel
                font: Theme.desktopSubtitleFontObject
            }
            PropertyChanges {
                target: principalAmountLabel
                font: Theme.desktopSubtitleFontObject
            }
            PropertyChanges {
                target: interestLabel
                font: Theme.desktopSubtitleFontObject
            }
            PropertyChanges {
                target: interestAmountLabel
                font: Theme.desktopSubtitleFontObject
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
            PropertyChanges {
                target: principalLabel
                font: Theme.desktopSubtitleFontObject
            }
            PropertyChanges {
                target: principalAmountLabel
                font: Theme.desktopSubtitleFontObject
            }
            PropertyChanges {
                target: interestLabel
                font: Theme.desktopSubtitleFontObject
            }
            PropertyChanges {
                target: interestAmountLabel
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
            PropertyChanges {
                target: principalLabel
                font: Theme.mobileTitleFontObject
            }
            PropertyChanges {
                target: principalAmountLabel
                font: Theme.mobileTitleFontObject
            }
            PropertyChanges {
                target: interestLabel
                font: Theme.mobileTitleFontObject
            }
            PropertyChanges {
                target: interestAmountLabel
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
            PropertyChanges {
                target: principalLabel
                font: Theme.smallTitleFontObject
            }
            PropertyChanges {
                target: principalAmountLabel
                font: Theme.smallTitleFontObject
            }
            PropertyChanges {
                target: interestLabel
                font: Theme.smallTitleFontObject
            }
            PropertyChanges {
                target: interestAmountLabel
                font: Theme.smallTitleFontObject
            }
        }

    ]
}
