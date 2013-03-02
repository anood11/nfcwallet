#include <QDebug>
#include "nfckeywallet.h"

NfcKeyWallet::NfcKeyWallet(QObject *parent) :
    QObject(parent)
{
    qDebug() << "construct";

}


QString
NfcKeyWallet::login(QString login)
{
    qDebug() << "testing";
    if (login=="fake")
    {

    }
    return "";
}
