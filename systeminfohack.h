#ifndef SYSTEMINFOHACK_H
#define SYSTEMINFOHACK_H

#include <QObject>

// harbour does not yet syupport qsystemInfo :( so we need this ugly hack
class SystemInfoHack : public QObject
{
    Q_OBJECT
public:
    explicit SystemInfoHack(QObject *parent = 0);

signals:
public slots:
    QString getIMEI();
    QString getTOHID();
};

#endif // SYSTEMINFOHACK_H
