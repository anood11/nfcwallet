#include <QDebug>
#include <openssl/sha.h>
#include <QUuid>
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

QString
NfcKeyWallet::generatePassword()
{
 //   uuid_t uuid;
//    uuid_generate(uuid);
    QByteArray text((char*)"uuid", 4);
    return text.toBase64().left(12);
}

QString
NfcKeyWallet::generateUUID()
{
//    uuid_t uuid;
  //  uuid_generate(uuid);
    QByteArray text((char*)"uuid", 4);
    return text.toHex();
}
