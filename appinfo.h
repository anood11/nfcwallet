/**
 * This file is public domain
 * Copyright Mikael Hermansson <mike@7b4.se>
 *
 * THERE IS NO WARRANTY FOR THE CODE, TO THE EXTENT PERMITTED BY APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE
 * COPYRIGHT HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM “AS IS” WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE ENTIRE RISK
 * AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL
 * NECESSARY SERVICING, REPAIR OR CORRECTION.
 */
#ifndef CONFIGDIR_H
#define CONFIGDIR_H

#include <QObject>
#include <QString>
#include <QCoreApplication>
#include "gen_config.h"
class AppInfo : public QObject
{
    Q_OBJECT
    QString config_path;
    QString data_path;
    QString install_path;
    QString app_name;
    QString app_fullname;
public:
    explicit AppInfo(QCoreApplication *app_path);
signals:

public slots:
    QString getDataPath(){return data_path;};
    QString getConfigPath(){return config_path;};
    QString getInstallPath(){return install_path;};
    QString getName(){return app_name;};
    QString getIcon(){ return "qrc:/"+app_fullname+".png"; };
    QString getVersion(){return QString(VERSION);};
    QString getLicenseTitle();
    QString getLicenseText();
    QString getChangeLogText();
};

#endif // CONFIGDIR_H
