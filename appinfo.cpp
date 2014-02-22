#include <QDir>
#include <QStandardPaths>
#include <QDebug>
#include "appinfo.h"
#include "gen_config.h"
AppInfo::AppInfo(QString appname) :
    QObject()
{
    // data paths append organization and appname
    data_path = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    // for some wierd reason config path does not append appname
    config_path = QDir(QStandardPaths::writableLocation(QStandardPaths::ConfigLocation)).filePath(appname);
    qDebug() << config_path;
    app_name = appname.replace("harbour-", "");
    version = QString(VERSION);

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
    return LICENSE;
}

QString AppInfo::getLicense()
{
    return QString("FIXME");
}
