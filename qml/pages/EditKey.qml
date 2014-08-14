import QtQuick 2.0
import Sailfish.Silica 1.0
import "../js/key_wallet.js" as Remote
Dialog
{
    id: page
    anchors.fill: parent
    onAccepted: {
        crypto.setKey( sinfo.getIMEI()+numpad.code);
        crypto.save()
        Remote.get_items()
        Remote.get_categorys()
    }
    function do_login(code)
    {
        accept()
    }

    canAccept: numpad.code.length > 3
    NumPad{ id: numpad; onLogin: do_login(code); }
}
