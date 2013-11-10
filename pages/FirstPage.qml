import QtQuick 1.1
import Sailfish.Silica 1.0

Page {
    id: page
    
    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent
        
        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "About Nfc Key Wallet"
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem{
                text: "Generate a PGP Key"
                onClicked: pageStack.push(Qt.resolvedUrl("MakeGPGPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: 800
        
        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.

        Label {
            width: page.width
            height: 100
            anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            text: "Use your<br />NFC Tag to Login"
            color: theme.secondaryHighlightColor
            font.pixelSize: theme.fontSizeExtraLarge
            MouseArea
            {
                anchors.fill: parent
                onClicked:
                {
                    nfc.login("fake")
                    pageStack.push(Qt.resolvedUrl("ListPage.qml"))
                }
            }
        }
    }
}


