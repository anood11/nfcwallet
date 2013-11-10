import QtQuick 1.1
import Sailfish.Silica 1.0
Dialog {
    id: myEditDialog

    anchors{
        fill: parent
        leftMargin: theme.paddingLarge
        rightMargin: theme.paddingLarge
    }
    property string name: ""
    property string email: ""
    property string comment: "nfckeywallet"
    onDone: {
        email = fieldEmail.text
        name = fieldName.text
        fieldEmail.enabled = false
        fieldName.enabled = false
        pgp.makePGPKey(name, email, "nfckeywallet")
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: childrenRect.height
        Column
        {
            id: dialogColumn
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            height: parent.height
            DialogHeader{
                acceptText: "Generate"
            }


            Label{
                text: "Your name:"
            }
            TextField{
                id: fieldName
                width: parent.width
                placeholderText: "Enter your name here"
                text: name
                focus: true
            }
            Label{
                text: "Your email:"
            }
            TextField{
                id: fieldEmail
                width: parent.width
                placeholderText: "Enter your email here"
                text: email
                focus: true
            }
        }
    }
}
