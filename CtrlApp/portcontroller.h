#ifndef PORTCONTROLLER_H
#define PORTCONTROLLER_H

#include <QObject>
#include <QTimer>

class PortController : public QObject
{
    Q_OBJECT
public:
    explicit PortController(QObject *parent = nullptr);

    QTimer timer;
    // 定义超时时间
    int timeout = 2000;
    // 定义数据接收标志位
    bool data_received = false;

    void resetTimer();

    void onDataReceived();

    bool machineStatus = false;



public slots:
    void updateQmlSlots(const QStringList speed);;
    void canReadDataSlots();


signals:
    void updateSpeeds(const QStringList speed);
    void isMachineOn(bool machineStatus);
};

#endif // PORTCONTROLLER_H
