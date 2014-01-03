#ifndef JSONSTORAGE_H
#define JSONSTORAGE_H

#include <QObject>
#include <QJsonArray>

class JsonStorage : public QObject
{
    Q_OBJECT
    QJsonArray items;
    QJsonArray categorys;
public:    
    explicit JsonStorage(QObject *parent = 0);
    void setItemArray(QJsonArray array);
signals:
public slots:
    void updateOrInsert(QString md5id, QString title, QString url, QString user, QString password, QString category);
    QString get_categorys(void);
    QString get_items(void);
    void remove(QString md5id);
    void addCategory(QString category);
};

#endif // JSONSTORAGE_H
