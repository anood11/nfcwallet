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
signals: public slots:
    void updateOrInsert(QString title, QString url, QString user, QString password, QString category);
    QString dump(void);
};

#endif // JSONSTORAGE_H
