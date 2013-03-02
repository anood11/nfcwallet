import QtQuick 1.1
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    initialPage: FirstPage { }
    property string version: "0.0.1"
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}


