import QtQuick 2.0
import Sailfish.Silica 1.0

BackgroundItem {
    id: itemButton

    property color color
    property alias text: buttonText.text
    property alias icon: logo.source
    property bool _playing: false
    property string mfile
    property int position
    property string uid

    // Taken from Jolla Notes
    Item {
        anchors.fill: parent
        clip: true

        Rectangle {
            rotation: 45 // diagonal gradient
            // Use square root of 2, rounded up a little bit, to make the
            // rotated square cover all of the parent square
            width: parent.width * 1.412136
            height: parent.height * 1.412136
            x: parent.width - width

            gradient: Gradient {
                GradientStop { position: 0.0; color: Theme.rgba(Theme.primaryColor, 0) }
                GradientStop { position: 1.0; color: Theme.rgba(Theme.primaryColor, 0.1) }
            }
        }
    }

    Item {
        anchors.fill: parent;
        anchors.margins: Theme.paddingLarge

        Text {
            id: buttonText
            anchors {
                top: parent.top
                topMargin: - (font.pixelSize / 4)
                left: parent.left
                right: parent.right
            }
            height: parent.height
            font { family: Theme.fontFamily; pixelSize: Theme.fontSizeMedium }
            color: Theme.primaryColor
            textFormat: Text.PlainText
            wrapMode: Text.Wrap
        }
        Image {
            id: playIcon
            anchors.bottom: colortag.bottom
            anchors.bottomMargin: Theme.paddingMedium
            anchors.left: colortag.left
            anchors.leftMargin: Theme.paddingMedium
            width: Theme.iconSizeSmall
            height: width
            source: "image://theme/icon-m-play"
            visible: _playing
        }

        Rectangle {
            id: colortag

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            width: Theme.itemSizeExtraSmall
            height: width/8
            radius: Math.round(Theme.paddingSmall/3)
            color: itemButton.color
        }
        Image {
            id: logo
            anchors.bottom: parent.bottom
            anchors.bottomMargin: Theme.paddingMedium
            anchors.right: parent.right
            anchors.rightMargin: Theme.paddingMedium
            width: parent.width / 3
            height: width
        }
    }
}
