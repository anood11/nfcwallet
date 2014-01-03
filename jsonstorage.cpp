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
    QJsonObject obj2;
    obj.insert("title", title);
    obj.insert("url", url);
    obj.insert("user", user);
    obj.insert("password", password);
    obj.insert("category", category);

    items.append(obj);

    foreach (const QJsonValue & cat, categorys)
    {
         obj = cat.toObject();
         if (obj["name"].toString() == category)
         {
             return ;
         }
    }

    obj2.insert("name", category);
    categorys.append(obj2);
}

QString JsonStorage::get_items(void)
{
    QJsonDocument doc;
    doc.setArray(items);
    qDebug() << doc.toJson();
    return doc.toJson();
}

QString JsonStorage::get_categorys(void)
{
    QJsonDocument doc;
    doc.setArray(categorys);
    return doc.toJson();
}
