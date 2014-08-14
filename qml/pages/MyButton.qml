import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
MouseArea
{
    id: button
    property alias text: tx.text
    width: 128
    height: 100
    onPressed: audio.play()
    SoundEffect{
        id: audio
        source: "/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav"
    }
    Text {
        id: tx
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -1
        color: button.pressed ? Theme.secondaryColor : Theme.highlightColor
        font.pixelSize: Theme.fontSizeExtraLarge+Theme.fontSizeMedium
    }

}
