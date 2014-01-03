#include <QDebug>
#include <QStandardPaths>
#include <QJsonDocument>
#include <QFile>
#include <QDir>
#include <QByteArray>
#include <QTextStream>
#include "jsonstorage.h"
#include "cryptostorage.h"


CryptoStorage::CryptoStorage(AppInfo *_appinfo, JsonStorage *_json) :
    QObject(),
    p_appinfo(_appinfo),
    p_json(_json)
{

}

bool CryptoStorage::login(QString pw)
{
    QFile file(p_appinfo->getConfigPath()+"/nfcwallet.json.crypt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        emit error(FileNotFound, "There were no database found");
        return false;
    }

    QJsonDocument doc;
    QByteArray bytes = file.readAll();//.replace("\n","");
    doc = QJsonDocument::fromJson(bytes);
    if (doc.array().empty())
    {
        emit error(Password, "Login failed");
        return false;
    }
    p_json->setItemArray(doc.array());
    qDebug("loaded?");
    qDebug() << doc.toJson();
    qDebug("loadeddo");

    return true;
}

void CryptoStorage::save()
{
    QString data;

    data = p_json->get_items();
    QByteArray bytes;
    bytes.append(data);
    while ((bytes.length() % 16) != 0)
    {
        // pad bytes at begining
        bytes.insert(0, '\n');
    }

    QFile file(p_appinfo->getConfigPath()+"/nfcwallet.json.crypt");
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    {
        qDebug("Could not save :(");
        emit error(CouldNotSave, "Could not save");
    }

    file.write(bytes);
    file.close();
}

