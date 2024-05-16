//pragma Strict
import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SharkAttack.Views
import SharkAttack.Controls

ApplicationWindow {
    id: root

    width: 1440
    height: 1080
    minimumHeight: 512
    minimumWidth: 512
    visible: true
    title: qsTr("Hello World")

    SystemTheme.theme: darkModeSwitch.checked ? SystemTheme.Dark : SystemTheme.Light

    header: ToolBar{
        SystemTheme.theme: SystemTheme.Dark
        RowLayout{
            anchors.fill: parent
            anchors.leftMargin: 12

            Label{
                text: qsTr("QSharkAttack!")
            }

            Item{
                Layout.fillWidth: true
            }
            Switch{
                id: darkModeSwitch
                text: qsTr("Dark Mode")
                Layout.fillWidth: false
            }
        }
    }

    Pane{
        id: background
        anchors{
            fill: parent
            margins: 64
        }

        ColumnLayout{
            anchors.fill: parent


            GridLayout {
                id: l1
                Layout.preferredHeight: 4
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: 1
                visible: false
                rowSpacing: 64
                LayoutItemProxy { target: userInputs }
                LayoutItemProxy { target: monthlyPayments }
            }

            GridLayout {
                id: l2
                Layout.preferredHeight: 4
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: 2
                visible: true
                columnSpacing: 64
                LayoutItemProxy { target: userInputs }
                LayoutItemProxy { target: monthlyPayments }
            }

            GridLayout{
                id: l3
                Layout.preferredHeight: 4
                Layout.fillWidth: true
                Layout.fillHeight: true
                columns: 1
                visible: false
                Item{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    SwipeView {
                        id: view
                        currentIndex: pageIndicator.currentIndex
                        anchors.fill: parent
                        anchors.margins: 16
                        spacing: 32
                        clip: true

                        Page {
                            title: qsTr("Input")
                            LayoutItemProxy{
                                target: userInputs
                                anchors.fill: parent
                            }
                        }
                        Page {
                            title: qsTr("Payment Breakdown")
                            LayoutItemProxy{
                                target: monthlyPayments
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
            }
        }
    }

    /***Start of ItemProxies
      See GridLayouts l1 and l2
    ***/
    InputView{
        id: userInputs
        Layout.fillHeight: true
        Layout.fillWidth: true
        onLoanAmountChanged: root.calculateLoan()
        onTermChanged: root.calculateLoan()
        onRateChanged: root.calculateLoan()
    }

    PaymentView{
        id: monthlyPayments
        Layout.fillHeight: true
        Layout.fillWidth: true
    }
    /***End of ItemProxies***/

    Component.onCompleted: {
        Theme.isBigDesktopLayout = Qt.binding( function(){
            return root.width >= Theme.width && root.width >= root.height
        })
        Theme.isSmallDesktopLayout = Qt.binding( function(){
            return root.width >= 647 && root.width < Theme.width && root.width >= root.height
        })
        Theme.isMobileLayout = Qt.binding( function(){
            return root.width < root.height
        })
        Theme.isSmallLayout = Qt.binding( function(){
            return root.width < 647 && root.width >= root.height
        })
    }

    onWidthChanged: {
        if (Theme.isBigDesktopLayout || Theme.isSmallDesktopLayout) {
            l1.visible = false
            l2.visible = true
            l3.visible = false
        } else if(Theme.isMobileLayout){
            l1.visible = true
            l2.visible = false
            l3.visible = false
        } else if(Theme.isSmallLayout){
            l1.visible = false
            l2.visible = false
            l3.visible = true
        }
    }

    function calculateLoan(){
        if(!userInputs.loanAmount || !userInputs.term || !userInputs.rate){
            return;
        }

        let interestRate = userInputs.rate /1200;
        let interestAmount = userInputs.loanAmount * interestRate;
        let monthlyAmount = (userInputs.loanAmount * interestRate) / (1 - Math.pow((1 + interestRate), -(userInputs.term*12)));
        let totalPayment = monthlyAmount + interestAmount;

        monthlyPayments.principalValue = monthlyAmount;
        monthlyPayments.interestValue = interestAmount;
        monthlyPayments.totalAmountValue = monthlyAmount + interestAmount;

        monthlyPayments.principalPercentage = (monthlyAmount/userInputs.loanAmount)*100;
        monthlyPayments.interestPercentage = (interestAmount/userInputs.loanAmount)*100;
    }
}
