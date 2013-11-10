
#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeContext>
#include "nfckeywallet.h"
#include "sailfishapplication.h"
#include "pgp_manager.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(Sailfish::createApplication(argc, argv));
    QScopedPointer<QDeclarativeView> view(Sailfish::createView("main.qml"));
    NfcKeyWallet nfc;
    GPGManager pgp;

    pgp.makePGPKey("Mikael Hermansson", "foo@foo.com", "test");

    view.data()->
            rootContext()->setContextProperty("nfc", &nfc);
    view.data()->
            rootContext()->setContextProperty("pgp", &pgp);


    Sailfish::showView(view.data());

    
    return app->exec();
}


