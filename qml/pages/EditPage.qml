import QtQuick 2.1
import Sailfish.Silica 1.0
import "../js/key_wallet.js" as Remote

Dialog {
    id: dialog
    width: Screen.width
    height: Screen.height
    property string title: ""
    property string url: ""
    property string iconUrl: ""
    property string login: ""
    property string password: ""
    property string group_uuid: ""
    property string category: ""
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
        category = modelCategorys.get(combo.currentIndex).title
        console.log(uuid)
        console.log(title)
        storage.updateOrInsert(title, url, login, password, category)
        crypto.save()
        Remote.get_items()
        Remopte.get_categorys()
//        Remote.wallet_post(uuid, group_uuid, url, title, login, password)
        // Remote.wallet
    }

    Flickable {
        contentHeight: (Theme.itemSizeSmall * 20) // this is brain dead
        //width: parent.width
               //        height: Theme.itemSizeSmall
        y: 80
        height: parent.height - 80
      //  anchors.top: header.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        Column
        {
            anchors.fill: parent
            width: parent.width
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

            TextField{
                id: fieldLogin
                width: parent.width
                placeholderText: "Enter Loginname"
                text: login
                Keys.onReturnPressed: {
                     fieldPassword.focus = true
                }
            }

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
            ComboBox {
                id: combo
                label: "Category:"
                height: Screen.height - 80
                value: category
                menu: ContextMenu {
                    TextField {
                        id: categoryEntry
                        placeholderText: qsTr("Enter new category or select from below")
                        width: parent.width
                        EnterKey.iconSource: categoryEntry.text.length == 0 ? "image://theme/icon-m-enter-close" : "image://theme/icon-m-enter-accept"
                        Keys.onReturnPressed: {
                            if (categoryEntry.text.length)
                            {
                                modelCategorys.append({"title" : categoryEntry.text});
                                combo.currentIndex = modelCategorys.count - 1
                                console.log("w"+combo.currentIndex+" d "+modelCategorys.get(combo.currentIndex).title)
                                category = modelCategorys.get(combo.currentIndex).title
                                categoryEntry.text = ""
                                categoryEntry.focus = false
                                combo.menu.hide()
                            }
                            else
                            {
                                categoryEntry.focus = false
                            }
                        }
                    }
                    Repeater{

                        model: modelCategorys
                        MenuItem { visible: !categoryEntry.focus; text: title }
                    }
                }
            }
        }
    }
}
