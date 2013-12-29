# The name of your app
TARGET = nfckeywallet

QT+=network quick qml
CONFIG += link_pkgconfig sailfishapp
PKGCONFIG += sailfishapp

# C++ sources
SOURCES += main.cpp \
    nfckeywallet.cpp \
    requesticon.cpp \
    pgp_manager.cpp

# C++ headers
HEADERS += \
    nfckeywallet.h \
    requesticon.h \
    pgp_manager.h

# QML files and folders
#qml.files = *.qml *.js scripts pages cover main.qml
#images.files=images

# The .desktop file
desktop.files = nfckeywallet.desktop



OTHER_FILES = rpm/nfckeywallet.yaml \
    images/nfckeyring.png \
    scripts/key_wallet.js \
    qml/nfckeywallet.qml \
    qml/pages/RemoveDialog.qml \
    qml/pages/PGPWait.qml \
    qml/pages/MakeGPGPage.qml \
    qml/pages/ListPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/EditPage.qml \
    qml/pages/AboutPage.qml \
    nfckeywallet.desktop \
    qml/pages/CreditsModel.qml \
    qml/pages/LicensePage.qml \
    qml/js/key_wallet.js \
    qml/pages/ListDelegate.qml \
    qml/pages/CategoryPage.qml

RESOURCES += \
    qrc.qrc


