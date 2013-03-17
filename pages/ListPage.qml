import QtQuick 1.1
import Sailfish.Silica 1.0
Page {

    ListModel {
        id: listModel
    }
    Component.onCompleted:
    {
        listModel.append({"iconUrl" : "http://www.google.com/s2/favicons?domain=www.icabanken.se", "uuid" : nfc.generateUUID(), "name" : "Ica kort","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Bank", "deleted" : false })
        listModel.append({"iconUrl" : "http://www.google.com/s2/favicons?domain=www.coop.se", "uuid" : nfc.generateUUID(), "name" : "Coop Kort","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Bank", "deleted" : false })
        listModel.append({"iconUrl" : "http://www.google.com/s2/favicons?domain=www.facebook.com", "uuid" : nfc.generateUUID(), "name" : "Facebook","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Social media", "deleted" : false })
        listModel.append({"iconUrl" : "http://twitter.com/favicon.ico", "uuid" : nfc.generateUUID(), "name" : "Twitter","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Social media", "deleted" : false })
        listModel.append({"iconUrl" : "http://ssl.gstatic.com/s2/oz/images/faviconr3.ico", "uuid" : nfc.generateUUID(), "name" : "Google+","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Social media", "deleted" : false })
        listModel.append({"iconUrl" : "http://talk.maemo.org/favicon.ico", "uuid" : nfc.generateUUID(), "name" : "Maemo","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Linux community", "deleted" : false })
        listModel.append({"iconUrl" : "http://merproject.org/images/mer-logo.png", "uuid" : nfc.generateUUID(), "name" : "Merproject","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Linux community", "deleted" : false })
        listModel.append({"iconUrl" : "http://www.jolla.com/favicon.ico", "uuid" : nfc.generateUUID(), "name" : "Jolla","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword(), "category" : "Companys", "deleted" : false })
    }
    SilicaListView {
        id: listView

        PullDownMenu {
            MenuItem {
                text: "About Nfc Key Wallet"
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                visible: main.uuid!=""
                text: "Remove"
                onClicked: pageStack.push(Qt.resolvedUrl("RemoveDialog.qml"))
            }
            MenuItem {
                visible: main.uuid!=""
                text: "Change"
                onClicked: pageStack.push(Qt.resolvedUrl("EditPage.qml"))
            }
            MenuItem {
                text: "Add"
                onClicked: pageStack.push(Qt.resolvedUrl("EditPage.qml"))
            }
        }

        anchors.fill: parent
        model: listModel

        header: PageHeader { title: "Nfc Key Wallet" }
        section {
            property: 'category'
            delegate: SectionHeader {
                text: section
            }
        }
        delegate: BackgroundItem {
            id: listViewDelegate
            visible: !deleted
            width: listView.width
            height: theme.itemSizeSmall
            Image{
                id: image
                width: 48
                height: 48
                anchors
                {
                    left: parent.left
                    top: parent.top
                    leftMargin: theme.paddingLarge
                }
                source: iconUrl
            }
            Label {
                id: title
                text: model.name
                font.pixelSize: theme.fontSizeLarge
                font.family: theme.fontFamilyHeading

                anchors{
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    leftMargin: theme.paddingLarge+64
                    rightMargin: theme.paddingLarge
                }
                color: parent.down ? theme.highlightColor : theme.primaryColor
            }
            Item {
                id: columns
                visible: false
                height: 0
                state: main.uuid==model.uuid ? "Details"  : ""
                anchors{
                    left: parent.left
                    right: parent.right
                    top: title.bottom
                    leftMargin: theme.paddingLarge+32
                    rightMargin: theme.paddingLarge
                }

                Label {
                    id: login
                    anchors{
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }

                    text: model.login
                    color: theme.primaryColor
                    //anchors.verticalCenter: parent.verticalCenter
                }
                Label {
                    id: pw

                    anchors{
                        left: parent.left
                        right: parent.right
                        top: login.bottom
                    }
                    text: model.password
                    color: theme.primaryColor
                  //  anchors.verticalCenter: parent.verticalCenter
                }

                states: [
                    State {
                        name: "Details"
                        PropertyChanges { target: listViewDelegate; height: theme.itemSizeSmall*2; }
                        PropertyChanges { target: columns; height: childrenRect. height; visible: true; } // Fill the entire list area with the detailed view
                    }
                ]
                transitions: Transition {
                    // Make the state changes smooth
                    ParallelAnimation {
//                            ColorAnimation { property: "color"; duration: 500 }
                        NumberAnimation { duration: 200; properties: "height" }
                    }
                }

            }
            Rectangle{
                anchors{
                    left: parent.left
                    right: parent.right
                    leftMargin: theme.paddingMedium
                    rightMargin: theme.paddingMedium
                    top: columns.bottom
                    topMargin: theme.paddingMedium
                }
                height: 2
                color: "black"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if (main.uuid==model.uuid)
                    {
                        main.uuid=""
                    }
                    else {
                        main.uuid=model.uuid
                    }
                 }
                onPressAndHold: pageStack.push(Qt.resolvedUrl("EditPage.qml"))
            }
        }
        VerticalScrollDecorator {}
    }
}
