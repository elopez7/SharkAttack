import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SharkAttack.Controls

Item{
    id: root
    property alias loanAmount: amountTextField.text
    property alias term: termSlider.value
    property alias rate: rateSlider.value
    readonly property real contentMinimumHeight : columnLayout.height/5
    width: 770
    height: 500
    ColumnLayout {
        id: columnLayout
        anchors.fill: parent
        Item{
            Layout.minimumHeight: contentMinimumHeight
            Layout.fillWidth: true
            RowLayout{
                anchors.fill: parent
                Label {
                    id: amountLabel
                    text: qsTr("Loan Amount")
                    font.pixelSize: 24
                }

                TextField {
                    id: amountTextField
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignRight
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    placeholderText: qsTr("$0.00")
                    validator: DoubleValidator{
                        bottom: 0
                        decimals: 2
                        notation: DoubleValidator.StandardNotation
                    }
                }
            }
        }

        Item{
            Layout.minimumHeight: contentMinimumHeight
            Layout.fillWidth: true
            RowLayout{
                anchors.fill: parent
                Label {
                    id: termLabel
                    text: qsTr("Loan Term")
                    font.pixelSize: 24
                    Layout.fillWidth: true
                }

                Label {
                    id: termLabelText
                    text: qsTr(termSlider.value + " years")
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignRight
                    Layout.fillWidth: true
                }
            }
        }

        Slider {
            id: termSlider
            value: 0.0
            Layout.fillWidth: true
            Layout.minimumHeight: contentMinimumHeight
            stepSize: 1
            to: 30
            snapMode: RangeSlider.SnapAlways
        }

        Item{
            Layout.fillWidth: true
            Layout.minimumHeight: contentMinimumHeight
            RowLayout{
                anchors.fill: parent
                Label {
                    id: rateLabel
                    text: qsTr("Loan Rate")
                    font.pixelSize: 24
                    Layout.fillWidth: true
                }

                Label {
                    id: rateLabelText
                    text: qsTr(rateSlider.value.toFixed(1) + "%")
                    font.pixelSize: 24
                    horizontalAlignment: Text.AlignRight
                    Layout.fillWidth: true
                }
            }
        }

        Slider {
            id: rateSlider
            value: 0.0
            Layout.fillWidth: true
            Layout.minimumHeight: contentMinimumHeight
            stepSize: 0.1
            to: 20
        }
    }
}
