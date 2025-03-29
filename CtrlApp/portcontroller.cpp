#include "portcontroller.h"

PortController::PortController(QObject *parent)
    : QObject{parent}
{
    QObject* contextObject = new QObject(this);
    QObject::connect(&timer, &QTimer::timeout, contextObject,[this](){
        // 接收不到机器人数据，超时后,判定机器人为待机状态
        // machineStatus = false;
        // emit isMachineOn(machineStatus);
        // qDebug("数据接收超时");
    });

}

void PortController::resetTimer()
{
    data_received = false;
}

void PortController::onDataReceived()
{
    data_received = true;
}

void PortController::updateQmlSlots(const QStringList speed){
    emit updateSpeeds(speed);

}

void PortController::canReadDataSlots()
{
    // 停止定时器
    timer.stop();
    // 重新启动定时器
    timer.start(timeout);
    machineStatus = true;
    emit isMachineOn(machineStatus);
    // qDebug("能接收到消息，重置定时器");

}

