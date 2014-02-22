#ifndef CONFIGDIR_H
#define CONFIGDIR_H

#include <QObject>
#include <QString>
class AppInfo : public QObject
{
    Q_OBJECT
    QString config_path;
    QString data_path;
    QString app_name;
    QString version;
public:
    explicit AppInfo(QString app_path);
signals:

public slots:
    QString getDataPath(){return data_path;};
    QString getConfigPath(){return config_path;};
    QString getAppName(){return app_name;};
    QString getVersion(){return version;};
    QString getLicenseTitle();
    QString getLicense();
};

#endif // CONFIGDIR_H
