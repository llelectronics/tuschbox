# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-tuschbox

CONFIG += sailfishapp

SOURCES += src/harbour-tuschbox.cpp \
    src/folderlistmodel/fileinfothread.cpp \
    src/folderlistmodel/qquickfolderlistmodel.cpp

OTHER_FILES += qml/harbour-tuschbox.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/harbour-tuschbox.changes.in \
    rpm/harbour-tuschbox.spec \
    rpm/harbour-tuschbox.yaml \
    translations/*.ts \
    harbour-tuschbox.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-tuschbox-de.ts \
                translations/harbour-tuschbox-hu.ts

DISTFILES += \
    qml/pages/components/ItemButton.qml \
    qml/pages/AboutPage.qml \
    qml/pages/images/mask-icon.png \
    qml/pages/sounds/karneval/jetzt-geht-los.ogg \
    qml/pages/sounds/karneval/tusch.ogg \
    qml/pages/images/stars-icon.png \
    qml/pages/js/db.js \
    qml/pages/EditButton.qml \
    qml/pages/OpenDialog.qml \
    qml/pages/SoundBoardList.qml \
    qml/pages/IconList.qml \
    qml/pages/images/blumen-icon.png \
    qml/pages/images/bye-icon.png \
    qml/pages/images/heart-icon.png \
    qml/pages/images/icon.png \
    qml/pages/images/konfetti-icon.png \
    qml/pages/images/ladybug-icon.png \
    qml/pages/images/trommel-icon.png \
    qml/pages/images/mask-icon.svg \
    qml/pages/sounds/karneval/bye-bye-my-love.ogg \
    qml/pages/sounds/karneval/kölle_alaaf.ogg \
    qml/pages/sounds/karneval/moment-moment-moment.ogg \
    qml/pages/sounds/karneval/ohohoh-ieo.ogg \
    qml/pages/sounds/karneval/schenk-mir-dein-herz.ogg \
    qml/pages/images/koelner_karneval-icon.png \
    qml/pages/images/koelsch-icon.png \
    qml/pages/images/luftballons-icon.png \
    qml/pages/images/rakete-icon.png

HEADERS += \
    src/folderlistmodel/fileinfothread_p.h \
    src/folderlistmodel/fileproperty_p.h \
    src/folderlistmodel/qquickfolderlistmodel.h \
    src/fmhelper.hpp

lupdate_only{
SOURCES =   qml/*.qml \
            qml/pages/*.qml \
            qml/cover/*.qm
}
