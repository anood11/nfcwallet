import QtQuick 1.1
import Sailfish.Silica 1.0
import "../scripts/key_wallet.js" as Remote

Dialog {
    id: myEditDialog

    anchors{
        fill: parent
        leftMargin: theme.paddingLarge
        rightMargin: theme.paddingLarge
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
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column
        {
            id: dialogColumn
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            height: parent.height
            DialogHeader{
                acceptText: "Save"
            }
            Label{
                text: "Site:"
            }
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
                        myEditDialog.name="hello"
    //                    console.log("focus lost"+fieldSite.text)
      //                  editDialog.url=text.toLowerCase()
        //                editDialog.name=editDialog.url.replace("http://www.","").replace("https://www.","")//.split(".")[0]

                    }
                }
                Keys.onReturnPressed: {
                    fieldTitle.focus = true
                    url = fieldSite.text
                    console.log ("f"+url)
                    title = url.replace("http://www.","").replace("https://www.","").replace("www.","").split(".")[0]
                }
            }
            Label{
                text: "Title:"
            }
            TextField{
                id: fieldTitle
                width: parent.width
                font.capitalization: Font.Capitalize
                placeholderText: "Enter site here"
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
                    fieldLogin.focus = true
                }
            }

            Label{
                text: "Login:"
            }
            TextField{
                id: fieldLogin
                width: parent.width
                placeholderText: "Enter Loginname"
                text: login
                Keys.onReturnPressed: {
                     fieldPassword.focus = true
                }
            }

            Label{
                id: pwLabel
                anchors.left: parent.left
                text: "Password:"
            }

            IconButton
            {
                height: pwLabel.height
                anchors.top: pwLabel.top
                anchors.right: parent.right
                icon.source: "../images/nfckeyring.png"
                icon.height: 48
                icon.width: 48
                onClicked: { password=nfc.generatePassword() }
            }

            TextField{
                id: fieldPassword
                width: parent.width
                placeholderText: "Enter Password"
                text: password
            }

            ComboBox {
                id: combo
                label: "Category:"
                wrap: false
                anchors.left: parent.left
                anchors.right: parent.right
                menu: ContextMenu {
                    MenuItem { text: "Communitys" }
                    MenuItem { text: "Banks" }
                    MenuItem { text: "Work" }
                    MenuItem { text: "Other" }
                }

            }
        }
    }
}
