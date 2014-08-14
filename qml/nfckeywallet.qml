import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
//import QtFeedback 5.0
import "pages"
ApplicationWindow
{
    id: main
    property string appicon: "qrc:/nfcwallet.png"
    property string uuid: ""
    property int selected: -1
    property string errorMsg: ""

    /* used by edit window */
    property string title: ""
    property string url: ""
    property string iconUrl: ""
    property string user: ""
    property string password: ""
    /* used in edit combo */
    property int categoryIndex: -1
    property string category: ""
    property string md5id: ""

    onSelectedChanged: watchdog.restart()

    SoundEffect {
        id: audio
        source: "/usr/share/sounds/jolla-ambient/stereo/general_warning.wav"
    }
    ListModel {
        id: modelItems
    }
    ListModel {
        id: modelCategorys
    }

    Timer
    {
        id: watchdog
        repeat: false
        running: false
        interval: 60000
        onTriggered: pageStack.pop()
    }

    QtObject {
        id: vib
        // "hack" until harbour allow HapticEffect
        function start()
        {
            // do  nothing...
        }
    }
    /*
        HapticsEffect {
            id: vib
            attackIntensity: 0.0
            attackTime: 100
            intensity: 1.0
            duration: 100
            fadeTime: 100
            fadeIntensity: 0.0
        }
    */
    Rectangle
    {
        id: errorDialog
        anchors.centerIn: parent
        border.width: 1
        visible: errorMsg != ""// ? 1.0 : 0.0
        width: 0
        height: 0
        scale: 1
        z: 1
        color: Theme.secondaryHighlightColor
        Label{
            font.pixelSize: Theme.fontSizeLarge
            text: errorMsg
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            wrapMode: Text.WordWrap
           // height: parent.height
        }
        MouseArea
        {
            id: mouseArea
            anchors.fill: parent
            onClicked: errorMsg = ""
        }

        transform: Scale { id: scaleTransform; origin.x: 25; origin.y: 25 }

        states: State {
            name: "active"; when: errorDialog.visible
            PropertyChanges { target: errorDialog; height: 200;}
            PropertyChanges { target: errorDialog; width: 400;}
        }
        transitions: Transition {
            NumberAnimation { property: "height"; duration: 200; }
            NumberAnimation { property: "width"; duration: 100; }
        }
    }

    Connections
    {
        target: crypto
        onError: { audio.play(); errorMsg = message; }
    }

    initialPage: pageStack.push(Qt.resolvedUrl("pages/FirstPage.qml"))
    cover: undefined
}


