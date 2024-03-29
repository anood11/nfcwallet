import QtQuick 2.1
import Sailfish.Silica 1.0
ListItem {
    id: delegate
    anchors.left: parent.left
    anchors.right: parent.right
    contentHeight: Theme.itemSizeSmall
    onClicked: { selected = (selected == model.index ? -1 : model.index); watchdog.restart(); }
    onPressAndHold: edit(model.md5id, model.title, model.url, model.login, model.password, model.category)
    Label {
        id: labelTitle
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Theme.paddingMedium
        anchors.rightMargin: Theme.paddingMedium
        font.pixelSize: Theme.fontSizeMedium
        color: index == selected ? Theme.highlightColor : Theme.primaryColor
        text: model.title
    }
    Item {
        id: subitem
        anchors.top: labelTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: labelUser.height + labelPassword.height + labelUrl.height + or.height
        opacity: 0.0
        Label {
            id: labelUrl
            anchors.top: subitem.top
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingMedium
            text: model.url
        }
        Label {
            id: labelUser
            anchors.top: labelUrl.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingMedium
            text: model.login
        }
        Label {
            id: labelPassword
            anchors.top: labelUser.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingMedium
            text: model.password
        }
        Separator{
            id: sep1
            anchors.top: labelPassword.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            width: 2
        }

        Item {
            id: or
            anchors.top: sep1.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            height: Theme.itemSizeSmall
            RemorseItem {
                anchors.top: parent.top
                id: remorse
            }

            IconButton {
                visible: Qt.md5("nfcwallet") != md5id
               anchors.left: parent.left
               anchors.leftMargin: Theme.paddingLarge
               icon.source: "image://theme/icon-l-delete"
               onClicked: remorse.execute(delegate, "Deleting", function() { storage.remove(md5id); crypto.save(); refresh(); } )
            }
            IconButton {
               visible: Qt.md5("nfcwallet") != md5id
               anchors.rightMargin: Theme.paddingLarge
               anchors.right: parent.right
               icon.source: "image://theme/icon-m-edit"
               icon.height: 48
               icon.width: 48
               onClicked: edit(model.md5id, model.title, model.url, model.login, model.password, model.category)
            }
        }
        Separator{
            anchors.top: or.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            width: 2
        }
    }

    states: [
        State {
            name: "selected"
            when: (selected==index)
            PropertyChanges {target: subitem; opacity: 1.0; }
            PropertyChanges { target: delegate;   contentHeight: Theme.itemSizeLarge + Theme.itemSizeLarge + Theme.itemSizeSmall;}
        }
    ]

}
