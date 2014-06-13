#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>
#include <sailfishapp.h>
#include <QFileInfo>
#include <QDebug>
#include "nfckeywallet.h"
#include "pgp_manager.h"
#include "appinfo.h"
#include "cryptostorage.h"
#include "jsonstorage.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    int exitcode;

    QGuiApplication *app = SailfishApp::application(argc, argv);
    QGuiApplication::setOrganizationName("7b4");

    app->setQuitOnLastWindowClosed(true);
    AppInfo appinfo(app);
    NfcKeyWallet nfc;

    //pgp.makePGPKey("Mikael Hermansson", "foo@foo.com", "test");

    QQuickView *view = SailfishApp::createView();
    JsonStorage *json  = new JsonStorage();
    CryptoStorage *crypto = new CryptoStorage(&appinfo, json);

    view->rootContext()->setContextProperty("nfc", &nfc);
    view->rootContext()->setContextProperty("storage", json);
    view->rootContext()->setContextProperty("crypto", crypto);
    view->rootContext()->setContextProperty("appinfo", &appinfo);
    view->setSource(SailfishApp::pathTo("/qml/nfckeywallet.qml"));
    view->showFullScreen();

#ifdef TEST_INSERT
    json->updateOrInsert("Ica Banken", "https://www.icabanken.se", "user", "password", "Banks");
    json->updateOrInsert("My other bank", "www.7b4.se", "user", "password", "Banks");
    json->updateOrInsert("My third bank", "", "", "0000", "Banks");
    json->updateOrInsert("Bitcoin", "", "", "0000", "Internet banks");
    json->updateOrInsert("My other bank", "", "user", "password", "Banks Login");
    json->updateOrInsert("Coop Kort", "", "", "0000", "Cards");
    json->updateOrInsert("Maemo Forum", "http://talk.maemo.org", "foo@localhost", "ElopIsAFool", "Communitys");
    json->updateOrInsert("Jolla2Gether", "http://together.jolla.com", "foo@localhost", "UFail", "Communitys");
    crypto->save();
#endif

    exitcode = app->exec();
    delete view;
    delete json;
    delete app;
    return exitcode;
}


