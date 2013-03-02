# The name of your app
TARGET = nfckeywallet

# C++ sources
SOURCES += main.cpp \
    nfckeywallet.cpp

# C++ headers
HEADERS += \
    nfckeywallet.h

# QML files and folders
qml.files = *.qml pages cover main.qml

# The .desktop file
desktop.files = nfckeywallet.desktop

# Please do not modify the following line.
include(sailfishapplication/sailfishapplication.pri)

OTHER_FILES = rpm/nfckeywallet.yaml \
    pages/AboutPage.qml

RESOURCES += \
    qrc.qrc

