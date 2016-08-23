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
import QtMultimedia 5.0
import "components"

Page {
    id: page

    property string soundboardName

    Component.onCompleted: {
        if (soundboardName == "default") {
            console.debug("Loading default profile...")
            setName.text = "Kölner Karneval"
            menuButtons.append({ btnId: "tuschBtn",
                                   name: "Tusch",
                                   colour: "gray",
                                   bicon: "images/mask-icon.png",
                                   sound: "sounds/karneval/tusch.ogg",
                                   playing: false,
                                   set: "Kölner Karneval"
                               })
            menuButtons.append({ btnId: "jetztgehtsLosBtn",
                                    name: "Jetzt gehts los",
                                    colour: "brown",
                                    bicon: "images/stars-icon.png",
                                    sound: "sounds/karneval/jetzt-geht-los.ogg",
                                    playing: false,
                                    set: "Kölner Karneval"
                                })
            menuButtons.append({ btnId: "momentBtn",
                                   name: "Moment Moment Moment",
                                   colour: "red",
                                   bicon: "images/blumen-icon.png",
                                   sound: "sounds/karneval/moment-moment-moment.ogg",
                                   playing: false,
                                   set: "Kölner Karneval"
                               })
            menuButtons.append({ btnId: "alaafBtn",
                                   name: "Kölle Alaaf",
                                   colour: "blue",
                                   bicon: "images/trommel-icon.png",
                                   sound: "sounds/karneval/kölle_alaaf.ogg",
                                   playing: false,
                                   set: "Kölner Karneval"
                               })
            menuButtons.append({ btnId: "herzBtn",
                                   name: "Schenk mir dein Herz",
                                   colour: "green",
                                   bicon: "images/heart-icon.png",
                                   sound: "sounds/karneval/schenk-mir-dein-herz.ogg",
                                   playing: false,
                                   set: "Kölner Karneval"
                               })
            menuButtons.append({ btnId: "ohohohieoBtn",
                                   name: "Oh oh oh - ieeeeeeooo",
                                   colour: "yellow",
                                   bicon: "images/konfetti-icon.png",
                                   sound: "sounds/karneval/ohohoh-ieo.ogg",
                                   playing: false,
                                   set: "Kölner Karneval"
                               })
            menuButtons.append({ btnId: "byebyeBtn",
                                   name: "Bye bye my love",
                                   colour: "orange",
                                   bicon: "images/bye-icon.png",
                                   sound: "sounds/karneval/bye-bye-my-love.ogg",
                                   playing: false,
                                   set: "Kölner Karneval"
                               })
        }
    }

    SilicaGridView {
        id: grid
        width: parent.width
        height: page.height - setName.height

        PullDownMenu {
            id: pulley
            MenuItem {
                text: "About "+ appname
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
            }
        }
        property PageHeader pageHeader

        header: PageHeader {
            id: pageHeader
            title: "Tuschbox"
            Component.onCompleted: grid.pageHeader = pageHeader
        }

        cellWidth: {
            if (page.orientation == Orientation.PortraitInverted || page.orientation == Orientation.Portrait)
                page.width / 2
            else
                page.width / 4
        }
        cellHeight: {
            if (page.orientation == Orientation.PortraitInverted || page.orientation == Orientation.Portrait)
                (page.height / 3) - pageHeader.height / 2
            else
                (page.height / 2) - pageHeader.height / 2
        }
        //model: menuButtons
        delegate: menuButtonsDelegate
        snapMode: GridView.SnapToRow
        populate: Transition {
            NumberAnimation { properties: "x,y"; duration: 400 }
        }
        Component.onCompleted: {
            grid.model = menuButtons
        }
    }

    ListModel {
        id: menuButtons

        // 7 Items

//        ListElement {
//            btnId: "tuschBtn"
//            name: "Tusch"
//            colour: "gray"
//            bicon: "images/mask-icon.png"
//            sound: "sounds/karneval/tusch.ogg"
//            playing: false
//            set: "Kölner Karneval"
//        }
//        ListElement {
//            btnId: "jetztgehtsLosBtn"
//            name: "Jetzt gehts los"
//            colour: "brown"
//            bicon: "images/stars-icon.png"
//            sound: "sounds/karneval/jetzt-geht-los.ogg"
//            playing: false
//            set: "Kölner Karneval"
//        }
//        ListElement {
//            btnId: "momentBtn"
//            name: "Moment Moment Moment"
//            colour: "red"
//            bicon: "images/blumen-icon.png"
//            sound: "sounds/karneval/moment-moment-moment.ogg"
//            playing: false
//            set: "Kölner Karneval"
//        }
//        ListElement {
//            btnId: "alaafBtn"
//            name: "Kölle Alaaf"
//            colour: "blue"
//            bicon: "images/trommel-icon.png"
//            sound: "sounds/karneval/kölle_alaaf.ogg"
//            playing: false
//            set: "Kölner Karneval"
//        }
//        ListElement {
//            btnId: "herzBtn"
//            name: "Schenk mir dein Herz"
//            colour: "green"
//            bicon: "images/heart-icon.png"
//            sound: "sounds/karneval/schenk-mir-dein-herz.ogg"
//            playing: false
//            set: "Kölner Karneval"
//        }
//        ListElement {
//            btnId: "ohohohieoBtn"
//            name: "Oh oh oh - ieeeeeeooo"
//            colour: "yellow"
//            bicon: "images/konfetti-icon.png"
//            sound: "sounds/karneval/ohohoh-ieo.ogg"
//            playing: false
//            set: "Kölner Karneval"
//        }
//        ListElement {
//            btnId: "byebyeBtn"
//            name: "Bye bye my love"
//            colour: "orange"
//            bicon: "images/bye-icon.png"
//            sound: "sounds/karneval/bye-bye-my-love.ogg"
//            playing: false
//            set: "Kölner Karneval"
//        }
    }

    Component {
        id: menuButtonsDelegate
        ItemButton {
            id: historyBtn
            width: grid.cellWidth
            height: grid.cellHeight
            text: qsTr(name)
            _playing: playing
            function play() {
                menuButtons.set(index, {"playing" : true})
                player.source = sound
                player.play()
            }

            onClicked: {
                if (player.playbackState == MediaPlayer.PlayingState) {
                    if (menuButtons.get(index).playing != true) {
                        player.stop()
                        play()
                    }
                    else player.stop()
                }
                else if (playing == false) {
                    // console.debug("[FirstPage.qml] Clicked button " + btnId + " to play " + sound)
                    play()
                }
            }
            color: colour
            icon: Qt.resolvedUrl(bicon)
        }
    }

    MediaPlayer {
        id: player
        onStopped: {
            for (var i=0; i<menuButtons.count; i++) {
                menuButtons.set(i, {"playing" : false})
            }
        }
    }

    SectionHeader {
        id: setName
        anchors.bottom: page.bottom
    }

}


