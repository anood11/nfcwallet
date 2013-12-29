import QtQuick 2.1
import Sailfish.Silica 1.0
import "../js/key_wallet.js" as Remote

Dialog {
    id: dialog
    anchors.fill: parent
    DialogHeader{
        id: header
        acceptText: "Save"
    }
    property string title: ""
    property string url: ""
    property string iconUrl: ""
    property string login: ""
    property string password: ""
    property string group_uuid: ""
    onAccepted: {
        if (uuid == "")
        {
            uuid = nfc.generateUUID()
        }
        if (group_uuid == "")
        {
            group_uuid = nfc.generateUUID()
        }
        url = fieldSite.text
        title = fieldTitle.text
        login = fieldLogin.text
        password = fieldPassword.text
        console.log(uuid)
        console.log(title)
        Remote.wallet_post(uuid, group_uuid, url, title, login, password)
        // Remote.wallet
    }

    SilicaFlickable {
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentHeight: (Theme.itemSizeSmall * 6) // this is brain dead
        Column {
            anchors.fill: parent
            TextField{
                id: fieldTitle
                width: parent.width
                font.capitalization: Font.Capitalize
                placeholderText: qsTr("Enter title here")
                inputMethodHints: Qt.ImhUrlCharactersOnly
                text: title
                focus: true
                onFocusChanged: {
                    if (!focus)
                    {
    //                        myEditDialog.title="hello"
    //                    console.log("focus lost"+fieldSite.text)
      //                  editDialog.url=text.toLowerCase()
        //                editDialog.name=editDialog.url.replace("http://www.","").replace("https://www.","")//.split(".")[0]

                    }
                }
                Keys.onReturnPressed: {
                    fieldSite.focus = true
                }
            }
/*
            Label
            {
                id: labelTitle
                font.pixelSize: Theme.fontSizeSmall
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingMedium
                text: "Title"
                color: fieldTitle.activeFocus ? Theme.highlightColor : Theme.primaryColor
            }
*/
            TextField{
                id: fieldSite
                width: parent.width
                placeholderText: "Enter site here"
                inputMethodHints: Qt.ImhUrlCharactersOnly
                text: url
                focus: true
                onFocusChanged: {
                    if (!focus)
                    {
                      //  myEditDialog.name="hello"
    //                    console.log("focus lost"+fieldSite.text)
      //                  editDialog.url=text.toLowerCase()
        //                editDialog.name=editDialog.url.replace("http://www.","").replace("https://www.","")//.split(".")[0]

                    }
                }
                Keys.onReturnPressed: {
                    fieldLogin.focus = true
                    url = fieldLogin.text
                    console.log ("f"+url)
                    title = url.replace("http://www.","").replace("https://www.","").replace("www.","").split(".")[0]
                }
            }
            /*
            Label{
                id: labelSite
                anchors.top: fieldSite.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: Theme.paddingLarge
                anchors.rightMargin: Theme.paddingMedium
                font.pixelSize: Theme.fontSizeSmall
                text: qsTr("Site")
                color: fieldSite.activeFocus ? Theme.highlightColor : Theme.primaryColor
                width: parent.width
            }
    */
            TextField{
                id: fieldLogin
                width: parent.width
                placeholderText: "Enter Loginname"
                text: login
                Keys.onReturnPressed: {
                     fieldPassword.focus = true
                }
            }
            /*
            Label{
                text: "Login:"
            }
            */
            Item {
                width: parent.width
                height: Theme.itemSizeSmall
                TextField{
                    id: fieldPassword
                    width: parent.width - 64
                    placeholderText: "Enter Password"
                    text: password
                    Keys.onReturnPressed: {
                         combo.focus = true
                    }
                }

                IconButton
                {
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.paddingLarge
                    icon.source: "qrc:/nfckeywallet.png"
                    icon.height: 48
                    icon.width: 48
                    onClicked: { password=nfc.generatePassword() }
                }
            }
/*
            Label{
                id: pwLabel
                text: "Password:"
            }
            */
            Item {
                width: parent.width
                height: Theme.itemSizeSmall
                ComboBox {
                    id: combo
                    label: "Category:"
                    menu: ContextMenu {
                        TextField {
                            id: categoryEntry
                            placeholderText: qsTr("Enter new category or select from below")
                            width: parent.width
                            Keys.onReturnPressed: { if (categoryEntry.text.length) dialog.accept(); }
                        }
                        MenuItem { text: "Communitys" }
                        MenuItem { text: "Banks" }
                        MenuItem { text: "Work" }
                        MenuItem { text: "Other" }
                    }
                }
                IconButton
                {
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.paddingLarge
                    icon.source: "image://theme/icon-l-add"
                    icon.width: 48 // FIXME hardcoded
                    icon.height: 48
                    onClicked: pageStack.push("CategoryPage.qml")
                }
            }
        }
    }
}
