#ifndef REQUESTICON_H
#define REQUESTICON_H

#include <QObject>

class RequestIcon : public QObject
{
    Q_OBJECT
public:
    explicit RequestIcon(QObject *parent = 0);
    
signals:
public slots:
    QString getIconURLFromUUID(QString uuid);
};

#endif // REQUESTICON_H
