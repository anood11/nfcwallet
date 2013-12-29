import QtQuick 2.1
import Sailfish.Silica 1.0

Dialog
{
    PageHeader {
        id: header
    }

    Item {
        anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }
}
