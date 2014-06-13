/**
 * This file is public domain
 * Copyright Mikael Hermansson <mike@7b4.se>
 */
#include <QCoreApplication>
#include <QDir>
#include <QStandardPaths>
#include <QFile>
#include <QDebug>
#include "appinfo.h"
#include "gen_config.h"
AppInfo::AppInfo(QCoreApplication *app) :
    QObject()
{
    // data paths append organization and appname
    data_path = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    // for some wierd reason config path does not append appname
    app_fullname = app->applicationName();
    config_path = QDir(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation)).filePath(app_fullname);
    app_name = app_fullname.replace("harbour-", "").replace("openrepo-", "");
    app_name = app_name.replace("_", " ");
    app_name = app_name.left(1).toUpper() + app_name.mid(1);

    QDir dir(config_path);
    if (!dir.exists()){
        dir.mkpath(config_path);
        // FIXME failcheck
    }
    dir.setPath(data_path);
    if (!dir.exists()){
        dir.mkpath(data_path);
        // FIXME failcheck
    }
}


QString AppInfo::getLicenseTitle()
{
#ifdef LICENSE_TITLE
    return QString(LICENSE_TITLE);
#else
    return QString("?");
#endif
}

QString AppInfo::getLicenseText()
{
#ifdef LICENSE_STRING
    return QString(LICENSE_STRING);
#else
    QString license("?");
    QFile file("/usr/share/harbour-"+app_fullname+"/LICENSE.txt");  // FIXME /usr/share shall not be hardcoded here!
    if (file.open(QIODevice::ReadOnly))
    {
        license = QString::fromUtf8(file.readAll());
    }

    return license;
#endif
}

QString AppInfo::getChangeLogText()
{
    QString changelog("?");
    QFile file("/usr/share/harbour-"+app_fullname+"/ChangeLog.txt");  // FIXME /usr/share shall not be hardcoded here!
    if (file.open(QIODevice::ReadOnly))
    {
        changelog = QString::fromUtf8(file.readAll());
    }

    return changelog;
}
