#include <QGuiApplication>
#include <QQuickView>
#include <QQmlContext>
#include <sailfishapp.h>
#include <QFileInfo>
#include <QDebug>
#include "nfckeywallet.h"
#include "pgp_manager.h"
#define VERSION "0.0.1"
Q_DECL_EXPORT int main(int argc, char *argv[])
{
    int exitcode;
    QFileInfo fi(argv[0]);
    QString appname = fi.baseName().replace("harbour-", "");
    qDebug() << appname;
    NfcKeyWallet nfc;
    GPGManager pgp;

    QGuiApplication *app = SailfishApp::application(argc, argv);
    app->setQuitOnLastWindowClosed(true);

    pgp.makePGPKey("Mikael Hermansson", "foo@foo.com", "test");

    QQuickView *view = SailfishApp::createView();
    view->rootContext()->setContextProperty("nfc", &nfc);
    view->rootContext()->setContextProperty("pgp", &pgp);
    view->rootContext()->setContextProperty("appname", appname);
    view->rootContext()->setContextProperty("version", VERSION);
    view->rootContext()->setContextProperty("license", QString("GPL 2.0"));
    view->setSource(SailfishApp::pathTo("/qml/nfckeywallet.qml"));
    view->showFullScreen();
    exitcode = app->exec();
    delete view;
    delete app;
    return exitcode;
}


