#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>
#include <sailfishapp.h>
#include <QFileInfo>
#include <QDebug>
#include "nfckeywallet.h"
#include "pgp_manager.h"
#include "jsonstorage.h"

#define VERSION "0.0.1"
Q_DECL_EXPORT int main(int argc, char *argv[])
{
    int exitcode;
    QFileInfo fi(argv[0]);
    QString appname = fi.baseName().replace("harbour-", "");
    qDebug() << appname;
    NfcKeyWallet nfc;
//    GPGManager pgp;

    QGuiApplication *app = SailfishApp::application(argc, argv);
    app->setQuitOnLastWindowClosed(true);

    //pgp.makePGPKey("Mikael Hermansson", "foo@foo.com", "test");

    QQuickView *view = SailfishApp::createView();
    JsonStorage *json  = new JsonStorage();
    json->updateOrInsert("Ica Banken", "https://www.icabanken.se", "user", "password", "Banks");
    json->updateOrInsert("My other bank", "www.7b4.se", "user", "password", "Banks");
    json->updateOrInsert("My third bank", "", "", "0000", "Banks");
    json->updateOrInsert("Bitcoin", "", "", "0000", "Internet banks");
    json->updateOrInsert("My other bank", "", "user", "password", "Banks Login");
    json->updateOrInsert("Coop Kort", "", "", "0000", "Cards");
    json->updateOrInsert("Maemo Forum", "http://talk.maemo.org", "foo@localhost", "ElopIsAFool", "Communitys");
    json->updateOrInsert("Jolla2Gether", "http://together.jolla.com", "foo@localhost", "UFail", "Communitys");
    view->rootContext()->setContextProperty("nfc", &nfc);
    view->rootContext()->setContextProperty("storage", json);
    view->rootContext()->setContextProperty("appname", appname);
    view->rootContext()->setContextProperty("version", VERSION);
    view->rootContext()->setContextProperty("license", QString("GPL 2.0"));
    view->setSource(SailfishApp::pathTo("/qml/nfckeywallet.qml"));
    view->showFullScreen();
    exitcode = app->exec();
    delete view;
    delete json;
    delete app;
    return exitcode;
}


