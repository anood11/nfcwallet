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

void JsonStorage::remove(QString md5id)
{
    int i = 0;
    foreach (const QJsonValue & cat, items)
    {
         QJsonObject o;
         o = cat.toObject();
         if (o["md5id"].toString() == md5id)
         {
             items.removeAt(i);
             return ;
         }
         i++;
    }
}

void JsonStorage::updateOrInsert(QString md5id, QString title, QString url, QString user, QString password, QString category)
{
    QJsonObject obj;
    int i = 0;
    foreach (const QJsonValue & cat, items)
    {
         QJsonObject o;
         o = cat.toObject();
         if (o["md5id"].toString() == md5id)
         {
             qDebug() << "changed";
             o["title"] = title;
             o["url"] = url;
             o["user"] = user;
             o["password"] = password;
             o["category"] = category;
             addCategory(category);
             items.replace(i, o);
             return ;
         }
         i++;
    }
    obj.insert("md5id", md5id);
    obj.insert("title", title);
    obj.insert("url", url);
    obj.insert("user", user);
    obj.insert("password", password);
    obj.insert("category", category);
    items.append(obj);

    addCategory(category);
}

void JsonStorage::addCategory(QString category)
{
    QJsonObject obj;
    foreach (const QJsonValue & cat, categorys)
    {
         obj = cat.toObject();
         if (obj["name"].toString() == category)
         {
             return ;
         }
    }

    obj.insert("name", category);
    categorys.append(obj);
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

void JsonStorage::setItemArray(QJsonArray array)
{
    items = array;
    foreach (const QJsonValue & cat, items)
    {
         QJsonObject o = cat.toObject();
         addCategory(o["category"].toString());
    }
}
