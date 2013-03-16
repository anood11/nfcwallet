import QtQuick 1.1
import Sailfish.Silica 1.0


Dialog {
    id: myEditDialog

    anchors{
        fill: parent
        leftMargin: theme.paddingLarge
        rightMargin: theme.paddingLarge
    }
    property string name: ""
    property string url: ""
    property string iconUrl: ""
    property string login: ""
    property string password: ""


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
