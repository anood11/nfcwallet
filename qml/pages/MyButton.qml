import QtQuick 2.0
import Sailfish.Silica 1.0
MouseArea
{
    property alias text: tx.text
    width: 128
    height: 100
    Text {
        id: tx
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -1
        color: Theme.secondaryHighlightColor //: Theme.secondaryColor
        font.pixelSize: Theme.fontSizeExtraLarge
    }

}
