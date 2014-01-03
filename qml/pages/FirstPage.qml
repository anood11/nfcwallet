import QtQuick 2.1
import Sailfish.Silica 1.0
import QtSystemInfo 5.0
Page {
    id: page
    anchors.fill: parent
    property string login: ""

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

    DeviceInfo
    {
        id: sinfo
    }

    function put_char(tx)
    {
        login = login+tx
    }

    function do_login(pw)
    {
        var imei = sinfo.imei(0)
        if (imei.length == 0)
        {
            imei = "012345678912345"
        }
        if (crypto.login(Qt.md5(imei+login)))
        {
                pageStack.push(Qt.resolvedUrl("ListPage.qml"))
        }
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "About Nfc Key Wallet"
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            /*
            MenuItem{
                text: "Generate a PGP Key"
                onClicked: pageStack.push(Qt.resolvedUrl("MakeGPGPage.qml"))
            }
            */
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: 800
        contentWidth: Screen.width
        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
//            anchors.topMargin: Theme.paddingLarge
            anchors.centerIn: parent
            anchors.leftMargin: Theme.paddingLarge
            anchors.rightMargin: Theme.paddingLarge
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
                font.pixelSize: Theme.fontSizeExtraLarge
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                readOnly: true
                text: login
                echoMode: TextInput.Password
            }

            Grid
            {
                y: 200 // stupid grid dont do as I told
                id: grid
                visible: false
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
                    icon.width: 64
                    icon.height: 64
                    onClicked: { login = "" }
                }
                MyButton{
                    text: "F"
                    onClicked: put_char(text)
                }
                IconButton
                {
                    width: 128
                    height: 100
                    icon.source: "image://theme/icon-m-next"
                    icon.width: 64
                    icon.height: 64
                    onClicked: do_login()
                }
            }
        }
    }
}


