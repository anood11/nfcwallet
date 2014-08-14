#include "systeminfohack.h"
#include <QFile>
#include <QDebug>
#include <QTextStream>
#include <QtDBus/QDBusInterface>
#include <QtDBus/QDBusReply>
#define IS_ALLOWED
SystemInfoHack::SystemInfoHack(QObject *parent) :
    QObject(parent)
{
}

QString SystemInfoHack::getIMEI()
{
    QFile file("/sys/devices/system/soc/soc0/imei");
    if (!file.exists() || !file.open(QFile::ReadOnly))
    {
        return "123456789012345";
    }

    QTextStream ts(&file);
    return ts.readLine(15);
}

#ifdef IS_ALLOWED
QString SystemInfoHack::getTOHID()
{
    QDBusInterface iface("com.jolla.tohd", "/com/jolla/tohd", "org.freedesktop.DBus.Properties",  QDBusConnection::systemBus());
    qDebug() << iface.isValid();
    qDebug() << iface.lastError();
    QDBusReply<QString> reply = iface.call("Get", "com.jolla.tohd", "TOHID");
//    qDebug () << reply.isValid();
//    qDebug() << iface.isValid();
//    qDebug() << iface.lastError();
    return reply;
}
#else
QString SystemInfoHack::getTOHID()
{
    return "";
}
#endif
