import QtQuick 2.1
import Sailfish.Silica 1.0

ListItem {
    id: delegate
    anchors.left: parent.left
    anchors.right: parent.right
    contentHeight: Theme.itemSizeSmall

    Label {
        id: labelTitle
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: Theme.paddingMedium
        anchors.rightMargin: Theme.paddingMedium
        font.pixelSize: Theme.fontSizeLarge
        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
        text: model.title
        MouseArea {
            anchors.fill: parent
            onClicked: { console.log("index"+model.index); selected = (selected == model.index ? -1 : model.index); }
            onPressAndHold: pageStack.push(Qt.resolvedUrl("EditPage.qml"))
        }
    }
    Item {
        id: subitem
        anchors.top: labelTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
      //  y: labelTitle.height
        height: labelUser.height + labelPassword.height
        opacity: 0.0
        Label {
            id: labelUser
            anchors.top: subitem.top
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
        MouseArea {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: sep1.bottom
            onClicked: { model.index = -1; }
        }

        Item {
            id: or
            anchors.top: sep1.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            height: childrenRect
            RemorseItem {
                anchors.top: parent.top
                id: remorse
            }

            IconButton {
               visible: !remorse.visible
               anchors.left: parent.left
               anchors.leftMargin: Theme.paddingLarge
               icon.source: "image://theme/icon-l-delete"
               onClicked: remorse.execute(delegate, "Deleting", function() { } )
            }
            IconButton {
               visible: !remorse.visible
               anchors.rightMargin: Theme.paddingLarge
               anchors.right: parent.right
               icon.source: "image://theme/icon-m-edit"
               icon.height: 48
               icon.width: 48
               onClicked: pageStack.push(Qt.resolvedUrl("EditPage.qml"))
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
            PropertyChanges { target: delegate;   contentHeight: Theme.itemSizeLarge + Theme.itemSizeSmall;}
        },
        State {
            name: "popup"
            when: (contextMenu != null && (contextMenu.parent == delegate))
            PropertyChanges {target: delegate; contentHeight:  Theme.itemSizeLarge * 3; }
        }
    ]

}
