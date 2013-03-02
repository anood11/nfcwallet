import QtQuick 1.1
import Sailfish.Silica 1.0
Page {

    ListModel {
        id: pagesModel

        ListElement {
            uuid: "1"
            site: "Ica kort"
            login: ""
            password: "1234"
            group: "Banks"
        }
        ListElement {
            uuid: "2"
            site: "Ica banken"
            login: "192001010101"
            password: "1234"
            group: "Banks"
        }
        ListElement {
            uuid: "3"
            site: "Coop"
            login: "192001010101"
            password: "1234"
            group: "Banks"
        }
        ListElement {
            uuid: "4"
            site: "Swedbank"
            login: "192001010101"
            password: "1234"
            group: "Bar"
        }
    }
    SilicaListView {
        id: listView
        property string uuid: ""
        anchors.fill: parent
        model: pagesModel

        header: PageHeader { title: "Nfc Key Wallet" }
        section {
            property: 'section'
            delegate: SectionHeader {
                text: model.group
            }
        }
        delegate: BackgroundItem {
            width: listView.width
            height: listView.uuid==model.uuid ? theme.itemSizeExtraLarge+16 : theme.itemSizeSmall
            Label {
                id: title
                text: model.site
                font.pixelSize: theme.fontSizeLarge
                font.family: theme.fontFamilyHeading

                anchors{
                    left: parent.left
                    right: parent.right
                    top: parent.top
                    leftMargin: theme.paddingLarge
                    rightMargin: theme.paddingLarge
                }
                color: parent.down ? theme.highlightColor : theme.primaryColor
                MouseArea{
                    anchors.fill: parent
                    onClicked: listView.uuid==model.uuid ? listView.uuid="" :  listView.uuid=model.uuid
                }
            }
            Item {
                id: columns
                visible: listView.uuid==model.uuid
                height: listView.uuid==model.uuid ? childrenRect. height : 0
                anchors{
                    left: parent.left
                    right: parent.right
                    top: title.bottom
                    leftMargin: theme.paddingLarge
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
