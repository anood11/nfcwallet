#include <QDir>
#include <QStandardPaths>
#include "appinfo.h"
#include "gen_config.h"
AppInfo::AppInfo(QString argv0) :
    QObject()
{
    QStringList path = QStandardPaths::standardLocations(QStandardPaths::ConfigLocation);
    config_path = path[0]+"/"+QFileInfo(argv0).baseName();
    app_name = QFileInfo(argv0).baseName().replace("harbour-", "");
    version = QString(VERSION);

    QDir dir(config_path);
    if (!dir.exists()){
        dir.mkdir(config_path);
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
