#include <QDebug>
#include <QStandardPaths>
#include <QCryptographicHash>
#include <QJsonDocument>
#include <QFile>
#include <QDir>
#include <QByteArray>
#include <QTextStream>
#include "jsonstorage.h"
#include "cryptostorage.h"
#include "libcrypto/aes/aes.h"

CryptoStorage::CryptoStorage(AppInfo *_appinfo, JsonStorage *_json) :
    QObject(),
    key(),
    p_appinfo(_appinfo),
    p_json(_json),
    cryptated()
{
    key.resize(32);
}

void CryptoStorage::setKey(QString pw)
{
    key = QCryptographicHash::hash(pw.toLatin1(), QCryptographicHash::Sha256);
    p_json->updateOrInsert(QCryptographicHash::hash("nfcwallet", QCryptographicHash::Md5).toHex(), "NfcWallet", "", "", key.toHex().toUpper(), "nfcwallet");
}

bool CryptoStorage::login(QString pw)
{
    int offset = 0;
    AES_KEY skey;
    QJsonDocument doc;
    QJsonParseError failed;
    QFile file(p_appinfo->getDataPath()+"/nfcwallet.json.crypt");
    setKey(pw);
    if (key.length() != 32)
    {
        emit error(Password, tr("key length error!?"));
        return false;
    }

    if (!file.open(QIODevice::ReadOnly))
    {
        p_json->updateOrInsert(QCryptographicHash::hash("nfcwallet", QCryptographicHash::Md5).toHex(), "NfcWallet", "", "", key.toHex().toUpper(), "nfcwallet");
        return true;
    }

    QByteArray bytes = file.readAll();
    cryptated.resize(bytes.length()+1);
   // qDebug() << "data " << bytes.toHex() << " dlenght " << bytes.length();

    private_AES_set_decrypt_key((uint8_t*)key.data(), 256, &skey);
    while (bytes.length())
    {
        AES_decrypt((uint8_t*)bytes.data(),(uint8_t*) &cryptated.data()[offset], &skey);
        bytes.remove(0, 16);
        offset += 16;
    };

    doc = QJsonDocument::fromJson(cryptated, &failed);
    if (doc.array().empty() && failed.error != QJsonParseError::NoError)
    {
        emit error(Password, tr("Login failed"));
        return false;
    }

    p_json->setItemArray(doc.array());

    cryptated.clear();
    qDebug() << doc.toJson();

    return true;
}

void CryptoStorage::save()
{
    AES_KEY skey;
    QString data;
    int offset = 0;

    if (key.length() != 32)
    {
        qDebug() << key.toHex();
        emit error(-1, tr("Key length is corrupt?"));
        return ;
    }
    private_AES_set_encrypt_key((uint8_t*)key.data(), 256, &skey);

    data = p_json->get_items();
    QByteArray bytes;
    bytes.append(data);
    while ((bytes.length() % 16) != 0)
    {
        // pad bytes at begining
        bytes.insert(0, '\n');
    }

    QFile file(p_appinfo->getDataPath()+"/nfcwallet.json.crypt");
    if (!file.open(QIODevice::WriteOnly))
    {
        qDebug("Could not save :(");
        emit error(CouldNotSave, "Could not save");
    }
    cryptated.resize(bytes.length());
    while (bytes.length())
    {
        AES_encrypt((uint8_t*)bytes.data(),(uint8_t*) &cryptated.data()[offset], &skey);
        bytes.remove(0, 16);
        offset += 16;
    }

    file.write(cryptated);
    file.close();
}

