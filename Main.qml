pragma Strict
import QtQml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SharkAttack.Views
import SharkAttack.Controls

ApplicationWindow {
    id: root

    width: 1920
    height: 1080
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

        AppHeader{
            id: applicationHeader
            anchors{
                left : parent.left
                right : parent.right
                top: parent.top
                bottom: parent.bottom
                leftMargin: 128
                rightMargin: 128
                topMargin: 0
                bottomMargin: 520
            }
            calculateButton.onClicked: {
                root.calculateLoan();
            }
        }

        GridLayout {
            id: l1
            columns: 1
            visible: false
            anchors{
                left: applicationHeader.left
                right: applicationHeader.right
                top: applicationHeader.bottom
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
                bottomMargin: 128
            }
            rowSpacing: 64
            LayoutItemProxy { target: userInputs }
            LayoutItemProxy { target: monthlyPayments }
        }

        GridLayout {
            id: l2
            columns: 2
            visible: true
            anchors{
                left: applicationHeader.left
                right: applicationHeader.right
                top: applicationHeader.bottom
                bottom: parent.bottom
                leftMargin: 0
                rightMargin: 0
                topMargin: 0
                bottomMargin: 128
            }
            columnSpacing: 64
            LayoutItemProxy { target: userInputs }
            LayoutItemProxy { target: monthlyPayments }
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

    onWidthChanged: {
        if (width < 1200) {
            l2.visible = false
            l1.visible = true
        } else {
            l1.visible = false
            l2.visible = true
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
