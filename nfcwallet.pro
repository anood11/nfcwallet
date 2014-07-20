# The name of your app
TARGET = nfcwallet

QT+=network quick qml
CONFIG += link_pkgconfig sailfishapp qt5-qtdeclarative-systeminfo qt5-qtsystem
PKGCONFIG += sailfishapp
DEFINES+=VERSION=\\\"$$VERSION\\\"
# C++ sources
SOURCES += main.cpp \
    nfckeywallet.cpp \
    requesticon.cpp \
    pgp_manager.cpp \
    jsonstorage.cpp \
    cryptostorage.cpp \
    libcrypto/aes/aes_core.c \
    appinfo.cpp

# C++ headers
HEADERS += \
    nfckeywallet.h \
    requesticon.h \
    pgp_manager.h \
    jsonstorage.h \
    cryptostorage.h \
    libcrypto/aes/aes.h \
    appinfo.h \
    gen_config.h

# QML files and folders
#qml.files = *.qml *.js scripts pages cover main.qml
#images.files=images

# The .desktop file
desktop.files = nfcwallet.desktop



OTHER_FILES = \
    images/nfckeyring.png \
    scripts/key_wallet.js \
    qml/nfckeywallet.qml \
    qml/pages/PGPWait.qml \
    qml/pages/MakeGPGPage.qml \
    qml/pages/ListPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/EditPage.qml \
    qml/pages/AboutPage.qml \
    qml/pages/CreditsModel.qml \
    qml/pages/LicensePage.qml \
    qml/js/key_wallet.js \
    qml/pages/ListDelegate.qml \
    qml/pages/CategoryPage.qml \
    qml/pages/MyButton.qml \
    rpm/nfcwallet.yaml \
    nfcwallet.desktop \
    qml/pages/NumPad.qml \
    qml/pages/EditKey.qml

RESOURCES += \
    qrc.qrc


