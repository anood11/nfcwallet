
#include <QApplication>
#include <QDeclarativeView>
#include <QDeclarativeContext>
#include "nfckeywallet.h"
#include "sailfishapplication.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(Sailfish::createApplication(argc, argv));
    QScopedPointer<QDeclarativeView> view(Sailfish::createView("main.qml"));
    NfcKeyWallet nfc;

    view.data()->
            rootContext()->setContextProperty("nfc", &nfc);

    Sailfish::showView(view.data());
    
    return app->exec();
}


