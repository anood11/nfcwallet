import QtQuick 1.1
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    id: main
    initialPage: FirstPage { }
    property string version: "0.0.1"
    property string uuid: ""
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}


