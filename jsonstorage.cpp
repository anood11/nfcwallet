#include <QJsonObject>
#include <QJsonValue>
#include <QJsonDocument>
#include <QDebug>
#include "jsonstorage.h"

JsonStorage::JsonStorage(QObject *parent) :
    QObject(parent),
    items(),
    categorys()
{
}

void JsonStorage::updateOrInsert(QString title, QString url, QString user, QString password, QString category)
{
    QJsonObject obj;
    obj.insert("title", title);
    obj.insert("url", url);
    obj.insert("user", user);
    obj.insert("password", password);
    obj.insert("category", category);

    items.append(obj);

    // FIXME
//    categorys.insert(QString(category));
}

QString JsonStorage::dump(void)
{
    QJsonDocument doc;
    doc.setArray(items);
    qDebug() << doc.toJson();
    return doc.toJson();
}
