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
    uint8_t key[16];
    uint8_t cbc[16];
    AppInfo *p_appinfo;
    JsonStorage *p_json;
public:
    explicit CryptoStorage(AppInfo *config, JsonStorage *_json);

signals:
    void error(int type, QString message);
public slots:
    void save();
    bool login(QString pw);
};

#endif // CRYPTOSTORAGE_H
