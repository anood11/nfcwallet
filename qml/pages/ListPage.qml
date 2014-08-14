import QtQuick 2.1
import Sailfish.Silica 1.0
import "../js/key_wallet.js" as Remote
Page {
    property Item contextMenu


    function edit(_md5, _title, _url, _login, _password, _category)
    {
        if (_title == "NfcWalletKey") // specialcase...
        {
            pageStack.push(Qt.resolvedUrl("EditKey.qml"))
        }
        else {
            md5id = _md5
            title = _title
            url = _url
            user = _login
            password = _password
            category = _category
            categoryIndex = Remote.get_index_from_category(category)
            pageStack.push(Qt.resolvedUrl("EditPage.qml"))
        }
    }
    Component.onCompleted: { Remote.get_categorys(); Remote.get_items(); }

    Label {
        anchors.centerIn: parent
        font.pixelSize: Theme.fontSizeLarge
        color: Theme.primaryColor
        text: "Use PulleyMenu to add an entry"
        visible: modelItems.count == 0
    }

    SilicaListView {
        id: listView
        PullDownMenu {
            MenuItem {
                text: "About Nfc Wallet"
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: "Add"
                onClicked: pageStack.push(Qt.resolvedUrl("EditPage.qml"))
            }
        }

        anchors.fill: parent
        model: modelItems

        header: PageHeader { title: "Nfc Wallet" }
        section {
            property: 'category'
            delegate: Label {
                text: section
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeMedium
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        delegate: ListDelegate { id: listViewDelegate}
        Component {
             id: contextMenuComponent
             ContextMenu {
                 MenuItem {
                     text: qsTr("Edit")
                     onClicked: console.log("Clicked Option 1")
                 }
                 MenuItem {
                     text: qsTr("Remove")
                     onClicked: console.log("Clicked Option 2")
                 }
             }
         }

        VerticalScrollDecorator {}
    }
    onStatusChanged:
    {
        if (status === PageStatus.Active)
            watchdog.restart();
    }

}
