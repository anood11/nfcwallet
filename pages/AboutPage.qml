import QtQuick 1.1
import Sailfish.Silica 1.0


Page {
//    orientationLock: PageOrientation.LockPortrait
        Column{
            id: column1
            anchors.fill: parent
            anchors.topMargin: 90
            spacing: 15

            Image{
                source: "qrc:/nfckeywallet.png"
                height: 128
                width: 128
                fillMode: Image.PreserveAspectFit
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }

            }
//            anchors.centerIn: parent

            Label{
                text: "Nfc Keywallet"
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: theme.fontSizeLarge
            }

            Label {
                font.pixelSize: theme.fontSizeMedium
                text: "Version: "+version
                anchors.horizontalCenter: parent.horizontalCenter

            }
            Rectangle{
                gradient: Gradient {
                      GradientStop { position: 0.0; color: "#333333" }
                      GradientStop { position: 1.0; color: "#777777" }
                  }
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: 3
                width: parent.width-64
            }

            Label {
                width: 360
                font.pixelSize: theme.fontSizeMedium
                text: "Copyright 2011-2013<br />Mikael Hermansson<br />with design help from<br />Sophie Wikström"
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            Rectangle{
                gradient: Gradient {
                      GradientStop { position: 0.0; color: "#333333" }
                      GradientStop { position: 1.0; color: "#777777" }
                  }
                anchors {
                    horizontalCenter: parent.horizontalCenter
                }
                height: 3
                width: parent.width-64
            }

            Label {
                width: parent.width-70
                font.pixelSize: theme.fontSizeSmall
                text: "This app is licensed under GPLv2.0"
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignHCenter
                height: 200
                wrapMode: Text.WordWrap
            }

        }
        MouseArea{
            anchors.fill: parent
            onClicked: pageStack.pop()
        }
}
