import QtQuick 2.1
import Sailfish.Silica 1.0
Page {
    id: page
    anchors.fill: parent

    function do_login(pw)
    {
        var imei = sinfo.getIMEI()
        var serial = sinfo.getTOHID()
        console.log("mat "+serial)
        if (crypto.login(imei+pw))
        {
            vib.start()
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
        NumPad { onLogin: do_login(code); }
    }

}


