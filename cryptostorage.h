#ifndef CRYPTOSTORAGE_H
#define CRYPTOSTORAGE_H

#include <QObject>
#include <QString>
#include <stdint.h>
#include "appinfo.h"
#include "jsonstorage.h"

enum LoginError{ Password = 0, FileNotFound = 1, CouldNotSave = 2};
class CryptoStorage : public QObject
{
    Q_OBJECT
    QByteArray key;
    AppInfo *p_appinfo;
    JsonStorage *p_json;
    QByteArray cryptated;
public:
    explicit CryptoStorage(AppInfo *config, JsonStorage *_json);

signals:
    void error(int type, QString message);
public slots:
    void save();
    bool login(QString pw);
};

#endif // CRYPTOSTORAGE_H
