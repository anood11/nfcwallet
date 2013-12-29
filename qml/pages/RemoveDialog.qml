import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    id: removeDialog

    anchors.fill: parent
    DialogHeader {
        acceptText: "Delete"
    }
    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        height: childrenRect.height
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Really delete?"
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "FIXME: get_from_uuid("+main.uuid+")"
        }
    }
}
