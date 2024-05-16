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

    /***Start of ItemProxies
      See GridLayouts l1, l2 and l3
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
                Layout.margins: 16
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
                            background: Rectangle{
                                color: SystemTheme.popupColor
                                //radius: 90

                                Behavior on color {
                                    ColorAnimation {
                                        duration: 150
                                    }
                                }
                            }

                            LayoutItemProxy{
                                target: userInputs
                                anchors.fill: parent
                            }
                        }
                        Page {
                            title: qsTr("Payment Breakdown")
                            background: Rectangle{
                                color: SystemTheme.popupColor
                                //radius: 90

                                Behavior on color {
                                    ColorAnimation {
                                        duration: 150
                                    }
                                }
                            }

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
        states:[
            State{
                name: "desktopLayout"
                when: Theme.isBigDesktopLayout || Theme.isSmallDesktopLayout
                PropertyChanges{
                    target: l1
                    visible: false
                }
                PropertyChanges{
                    target: l2
                    visible: true
                }
                PropertyChanges{
                    target: l3
                    visible: false
                }
            },
            State{
                name: "mobileLayout"
                when: Theme.isMobileLayout
                PropertyChanges{
                    target: l1
                    visible: true
                }
                PropertyChanges{
                    target: l2
                    visible: false
                }
                PropertyChanges{
                    target: l3
                    visible: false
                }
                PropertyChanges{
                    target: background
                    anchors.margins: 16
                }
            },
            State{
                name: "smallLayout"
                when: Theme.isSmallLayout
                PropertyChanges{
                    target: l1
                    visible: false
                }
                PropertyChanges{
                    target: l2
                    visible: false
                }
                PropertyChanges{
                    target: l3
                    visible: true
                }
            }
        ]
    }

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
