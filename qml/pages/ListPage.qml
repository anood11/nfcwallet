import QtQuick 2.1
import Sailfish.Silica 1.0
import "../js/key_wallet.js" as Remote
Page {
    property Item contextMenu
    Component.onCompleted: { Remote.get_categorys(); Remote.get_items(); }

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
            delegate: SectionHeader {
                text: section
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
}
