# The name of your app
TARGET = harbour-nfcwallet

QT+=network quick qml dbus
CONFIG += link_pkgconfig sailfishapp
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
    appinfo.cpp \
    libcrypto/aes/aes_ecb.c \
    systeminfohack.cpp

# C++ headers
HEADERS += \
    nfckeywallet.h \
    requesticon.h \
    pgp_manager.h \
    jsonstorage.h \
    cryptostorage.h \
    libcrypto/aes/aes.h \
    appinfo.h \
    gen_config.h \
    libcrypto/aes/aes_locl.h \
    systeminfohack.h

# QML files and folders
#qml.files = *.qml *.js scripts pages cover main.qml
#images.files=images

# The .desktop file
desktop.files = nfcwallet.desktop



OTHER_FILES = \
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
    rpm/harbour-nfcwallet.yaml \
    harbour-nfcwallet.desktop \
    qml/pages/NumPad.qml \
    qml/pages/EditKey.qml \
    images/nfckeywallet.png

RESOURCES += \
    qrc.qrc


docs.path=/usr/share/${TARGET}
docs.files=ChangeLog.txt LICENSE.txt
INSTALLS += docs
