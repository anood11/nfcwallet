import QtQuick 2.0
import Sailfish.Silica 1.0
import QtFeedback 5.0
import QtSystemInfo 5.0
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
        interval: 30000
        onTriggered: pageStack.pop()
    }

    HapticsEffect {
        id: vib
        attackIntensity: 0.0
        attackTime: 100
        intensity: 1.0
        duration: 100
        fadeTime: 100
        fadeIntensity: 0.0
    }

    DeviceInfo
    {
        id: sinfo
        function getIMEI()
        {
            var imei = sinfo.imei(0);
            if (imei.length == 0)
            {
                imei = "012345678912345"
            }
            return imei;
        }
    }

    Rectangle
    {
        id: errorDialog
        visible: errorMsg != ""
        anchors.centerIn: parent
        border.width: 1
        opacity: 0.7
        width: 400
        height: 400
        scale: 1
        z: 1
        Text{
            anchors.fill: parent
            font.pixelSize: Theme.fontSizeLarge
            color: Theme.primaryColor
            text: errorMsg
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            wrapMode: Text.WordWrap
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
            PropertyChanges { target: scaleTransform; xScale: 1; yScale: 1;}
        }
        transitions: Transition {
            NumberAnimation { property: "xScale"; duration: 1000 }
        }
    }

    Connections
    {
        target: crypto
        onError: errorMsg = message
    }

    initialPage: pageStack.push(Qt.resolvedUrl("pages/FirstPage.qml"))
    cover: undefined
}


