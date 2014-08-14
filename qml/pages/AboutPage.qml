import QtQuick 2.0
import Sailfish.Silica 1.0
Page {
    CreditsModel {id: credits}

    PageHeader {
        title: qsTr("About")
    }

    Timer {
        running: true
        interval: 500
        repeat: false
        onTriggered: pageStack.pushAttached("ChangeLog.qml")
    }
    Column{
        id: column1
        anchors.fill: parent
        anchors.topMargin: Theme.paddingLarge * 4
        spacing: Theme.paddingMedium
        Image{
            source: appinfo.getIcon()
            height: 106
            width: 106
            fillMode: Image.PreserveAspectFit
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
        }
        Label {
            text: appinfo.getName()+" v"+appinfo.getVersion()
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Separator{
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            height: 3
            width: parent.width - (Theme.paddingLarge * 2)
        }

        Label {
            width: 360
            font.pixelSize: Theme.fontSizeMedium
            text: "Copyright 2014 Mikael Hermansson"
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignHCenter
            //wrapMode: Text.WordWrap
            //height: Theme.fontSizeMedium * 1 + 20
        }

        Repeater{
            model: credits
            Item {
                height: url ? button.height : label.height
                width: parent.width
                Label  {
                    id: label
                    visible: typeof titleurl == "undefined" ? true : false
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: title
                    font.pixelSize: Theme.fontSizeSmall
                }
                Button  {
                    id: button
                    visible: typeof titleurl == "undefined" ? false : true
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: typeof titleurl == "undefined" ? "" : titleurl
                    onClicked: Qt.openUrlExternally(url+appinfo.name()+" v"+appinfo.getVersion())
                }
            }
        }

        Separator{
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            height: 3
            width: parent.width - (Theme.paddingLarge * 2)
        }

        Button {
            text: "License "+appinfo.getLicenseTitle()
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: pageStack.push(Qt.resolvedUrl("LicensePage.qml"))
        }

        IconButton {
            icon.source: "qrc:/images/PayBtn_BgImg.png"
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: pressed ? 0.5 : 1.0
            width: 200
            height: 80
            Text {
                y: 8
                height: 60
                width: 80
                font.pixelSize: Theme.fontSizeSmall
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Donate")
            }
            onClicked: Qt.openUrlExternally("https://www.payson.se/SendMoney/?De=My+money+sailfish+app&Se=mike%407b4.se&Cost=0&Currency=SEK&&Sp=1")
        }

    }
}
