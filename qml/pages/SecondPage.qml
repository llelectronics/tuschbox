/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog {
    id: newSoundBoardDialog

    property alias soundBoardName: newSoundboardName.text

    canAccept: false
    acceptDestination: Qt.resolvedUrl("FirstPage.qml")
    //acceptDestinationProperties: { "soundboardName": soundBoardName }
    acceptDestinationAction: PageStackAction.Replace

    onAccepted: {
        acceptDestinationInstance.soundboardName = soundBoardName
    }

    DialogHeader {
        id: header
        acceptText: qsTr("Create")
        title: qsTr("Create new Soundboard")
    }

    SilicaFlickable {
        id: flick
        width: parent.width
        height: parent.height - header.height
        anchors.top: header.bottom
        TextField {
            id: newSoundboardName
            focus: true
            width: parent.width - 2 * Theme.paddingMedium
            anchors.top: parent.top
            anchors.topMargin: Theme.paddingLarge
            anchors.left: parent.left
            anchors.leftMargin: Theme.paddingMedium
            placeholderText: qsTr("Name of the new soundboard")
            label: qsTr("Soundboard Name")
            onTextChanged: {
                if (text != "") { newSoundBoardDialog.canAccept = true; }
                else newSoundBoardDialog.canAccept = false
            }
        }
    }
}





