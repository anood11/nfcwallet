import QtQuick 2.1
import Sailfish.Silica 1.0
import "../js/key_wallet.js" as Remote

Dialog {
    id: dialog
    width: Screen.width
    height: Screen.height

    function reset_fields()
    {
        console.log("reset_fields")
        md5id = ""
        title = ""
        url = ""
        category = ""
        categoryIndex = -1
//        user = ""
        password = ""
    }
    onAccepted: {
        if (md5id == "")
        {
            md5id = Qt.md5(fieldTitle.text)
        }

        url = fieldSite.text
        title = fieldTitle.text
        user = fieldLogin.text
        password = fieldPassword.text
        category = modelCategorys.get(combo.currentIndex).title
        console.log(md5id)
        console.log(title)
        console.log(category)
        storage.updateOrInsert(md5id, title, url, user, password, category)
        crypto.save()
        reset_fields()

        Remote.get_items()
        Remote.get_categorys()
    }

    onRejected: {reset_fields();  }

    Component.onCompleted: watchdog.stop()

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
                label: qsTr("Title")
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
                placeholderText: qsTr("Enter site here")
                label: qsTr("Site")
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
                placeholderText: qsTr("Enter Login")
                label: qsTr("Login")
                text: user
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
                    placeholderText: qsTr("Enter Password")
                    label: qsTr("Password")
                    text: password
                    Keys.onReturnPressed: {
                         combo.focus = true
                    }
                }

                IconButton
                {
                    visible: fieldPassword.text == ""
                    anchors.right: parent.right
                    anchors.rightMargin: Theme.paddingLarge
                    icon.source: "qrc:/nfcwallet.png"
                    icon.height: 48
                    icon.width: 48
                    onClicked: { password=nfc.generatePassword() }
                }
            }
            ComboBox {
                id: combo
                label: qsTr("Category")
                height: Screen.height - 80
                currentIndex: categoryIndex
//                value: category
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
                                categoryIndex = modelCategorys.count - 1
                          //      category = categoryEntry.text
                                //categoryIndex = modelCategorys.get(combo.currentIndex).title
                              //  console.log("cind "+combo.currentIndex+" ind "+categoryIndex+" t "+modelCategorys.get(combo.currentIndex).title)
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
