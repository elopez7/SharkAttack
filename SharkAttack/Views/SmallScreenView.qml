import QtQuick
import QtQuick.Controls

Item{
    id: root
    SwipeView {
        id: view
        currentIndex: pageIndicator.currentIndex
        anchors.fill: parent
        anchors.margins: 16
        spacing: 32

        Page {
            title: qsTr("Input")
            InputView{
                anchors.fill: parent
            }
        }
        Page {
            title: qsTr("Payment Breakdown")
            PaymentView{
                anchors.fill: parent
            }
        }
    }

    PageIndicator {
        id: pageIndicator
        interactive: true
        count: view.count
        currentIndex: view.currentIndex

        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
