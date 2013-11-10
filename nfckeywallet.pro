# The name of your app
TARGET = nfckeywallet

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
qml.files = *.qml *.js scripts pages cover main.qml
images.files=images

# The .desktop file
desktop.files = nfckeywallet.desktop

# Please do not modify the following line.
include(sailfishapplication/sailfishapplication.pri)

images.path=$$DEPLOYMENT_PATH/

OTHER_FILES = rpm/nfckeywallet.yaml \
    images/nfckeyring.png \
    scripts/key_wallet.js

RESOURCES += \
    qrc.qrc

INSTALLS+=images

INCLUDEPATH+=/usr/include
LIBS+=-luuid
