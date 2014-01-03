#include <QDebug>
#include <openssl/sha.h>
#include <QTime>
#include <QByteArray>
#include <QCryptographicHash>
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

    QTime time = QTime::currentTime();
    qsrand((uint)time.msec());
    QString str=QString("%1").arg(qrand());
    /* should be safe only numbers */
    str = QCryptographicHash::hash(str.toLocal8Bit(), QCryptographicHash::Sha256);

    /* should be safe only ASCI hex */


    return str.toLatin1().toBase64().replace("/","_").left(12);
}

QString
NfcKeyWallet::generateUUID()
{
//    uuid_t uuid;
  //  uuid_generate(uuid);
    QByteArray text((char*)"uuid", 4);
    return text.toHex();
}
