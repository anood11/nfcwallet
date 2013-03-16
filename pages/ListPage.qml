import QtQuick 1.1
import Sailfish.Silica 1.0
Page {

    ListModel {
        id: listModel

/*
        ListElement {
            uuid: nfc.generateUUID()
            url: "http://www.icabanken.se"
            iconUrl: "http://www.google.com/s2/favicons?domain=www.icabanken.se"
            name: "Ica kort"
            login: "vafan"
            password: "1234"
            group: "Banks"
            deleted: false
        }
        ListElement {
            uuid: nfc.generateUUID()
            url: "http://www.icabanken.se"
            iconUrl: "http://www.fvicon.com/http://www.icabanken.se"
            name: "Ica banken"
            login: "192001010101"
            password: "1234"
            group: "Banks"
            deleted: false
        }
        ListElement {
            uuid: nfc.generateUUID()
            url: "http://www.coop.se"
            iconUrl: "http://www.google.com/s2/favicons?domain=www.coop.se"
            name: "Coop"
            login: "192001010101"
            password: "1234"
            group: "Banks"
            deleted: false
        }
        ListElement {
            uuid: nfc.generateUUID()
            name: "Swedbank"
            url: "http://www.swedbank.se"
            iconUrl: "http://www.fvicon.com/http://www.swedbank.se"
            login: "192001010101"
            password: "1234"
            group: "Bar"
            deleted: true
        }
        */
    }
    Component.onCompleted:
    {
        listModel.append({"iconUrl" : "http://www.google.com/s2/favicons?domain=www.icabanken.se", "uuid" : nfc.generateUUID(), "name" : "Ica kort","login" : "foobar@ihatespam.com", "password" : nfc.generatePassword() })
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
            property: 'group'
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
                MouseArea{
                    anchors.fill: parent
                    onClicked: { if (main.uuid==model.uuid)
                                {
                                    main.uuid=""
                         //           columns.state=''
                                }
                                else {
                                    main.uuid=model.uuid
//                                    columns.state='Details'
                                }
                        }
                }
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
        }
        VerticalScrollDecorator {}
    }
}
