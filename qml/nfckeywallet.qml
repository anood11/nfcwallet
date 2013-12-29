import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    id: main
    initialPage: FirstPage { }
    property string appicon: "qrc:/nfckeywallet.png"
    property string uuid: ""
    property int selected: -1
    cover: undefined
}


