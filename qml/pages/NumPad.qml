import QtQuick 2.0
import Sailfish.Silica 1.0
Column {
    id: numpad
    anchors.centerIn: parent
    anchors.leftMargin: Theme.paddingLarge
    anchors.rightMargin: Theme.paddingLarge
    property string code: ""
    signal login
    function put_char(tx)
    {
        vib.start()
        code = code + tx
    }

    ListModel{
        id: buttons
        ListElement  { title: "0"; character : "0";}
        ListElement  { title: "1"; character : "1";}
        ListElement  { title: "2"; character : "2";}
        ListElement  { title: "3"; character : "3";}
        ListElement  { title: "4"; character : "4";}
        ListElement  { title: "5"; character : "5";}
        ListElement  { title: "6"; character : "6";}
        ListElement  { title: "7"; character : "7";}
        ListElement  { title: "8"; character : "8";}
        ListElement  { title: "9"; character : "9";}
        ListElement  { title: "A"; character : "A";}
        ListElement  { title: "B"; character : "B";}
        ListElement  { title: "C"; character : "C";}
        ListElement  { title: "D"; character : "D";}
        ListElement  { title: "E"; character : "E";}
    }

//            anchors.topMargin: Theme.paddingLarge
    MouseArea
    {
        id: sib
        visible: !grid.visible
        width: page.width
        height: 100
        onClicked:
        {
            grid.visible = true
        }
        Text {
//                anchors.centerIn: parent
//                anchors.horizontalCenter: parent.horizontalCenter
            height: parent.height
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            text: "<center>Use your</center><br /><center>NFC Tag to Login</center><br /><center>Or tap to enter Pin</center>"
            color: sib.pressed ? Theme.secondaryHighlightColor : Theme.secondaryColor
            font.pixelSize: Theme.fontSizeExtraLarge
        }
    }

    Item
    {
        /* Hack to add extra space */
        height: Theme.paddingLarge * 4
        width: parent.width
    }
    TextField {
        id: entry
        //anchors.top: parent.top
        width: parent.width
        font.pixelSize: Theme.fontSizeExtraLarge+Theme.fontSizeMedium
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        readOnly: true
        text: code
        echoMode: TextInput.Password
    }

    Grid
    {
        y: 200 // stupid grid dont do as I told
        id: grid
        visible: true
        rows: 7
        columns: 3
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater {
            model: buttons
//                    width: parent.width
//                  height: 128 * 15
            MyButton{
                text: title
                onClicked: put_char(character)
            }
        }


        IconButton
        {
            width: 128
            height: 100
            icon.source: "image://theme/icon-l-cancel"
            icon.width: 86
            icon.height: 86
            onClicked: {vib.start(); code = "" }
        }
        MyButton{
            text: "F"
            onClicked: { put_char(text);  }
        }
        IconButton
        {
            width: 128
            height: 100
            icon.source: "image://theme/icon-m-next"
            icon.width: 86
            icon.height: 86
            onClicked: { numpad.login(code); code = ""; }
        }
    }
}
