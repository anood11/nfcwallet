#ifndef NFCKEYWALLET_H
#define NFCKEYWALLET_H

#include <QObject>

class NfcKeyWallet : public QObject
{
    Q_OBJECT
public:
    explicit NfcKeyWallet(QObject *parent = 0);
    
signals:
    
public slots:
    QString login(QString login);
    QString generatePassword();
    QString generateUUID();
};

#endif // NFCKEYWALLET_H
