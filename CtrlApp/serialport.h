#ifndef SERIALPORT_H
#define SERIALPORT_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QThread>
#include <qtimer.h>
#include <QDebug>


// #include <QList>

class SerialPort : public QObject
{
    Q_OBJECT
public:
    explicit SerialPort(QObject *parent = nullptr);

    Q_INVOKABLE QStringList getSerialPortList();
    Q_INVOKABLE QList<qint32> getStandardBaudRates();

    Q_INVOKABLE void openSerialPort(QString PortName);
    Q_INVOKABLE void closeSerialPort();

    Q_INVOKABLE void setBytesData(int BytesNum,char BytesData);
    Q_INVOKABLE char getBytesData(int BytesNum);

    QByteArray getAllBytesData() const;
    void setAllBytesData(const QByteArray &newAllBytesData);


    QTimer timer;
    QByteArray allBytesData;
    Q_INVOKABLE void readData();
    Q_INVOKABLE void writeAllBytesData();


private:
    QSerialPort m_serialPort;


signals:
    void allBytesDataChanged();
    void readAllDataChanged();
    void motorSpeedUpdated(const QStringList speed);
    void canReadData();
};

#endif // SERIALPORT_H
