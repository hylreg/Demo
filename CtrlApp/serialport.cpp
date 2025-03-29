#include "serialport.h"
#include <math.h>

SerialPort::SerialPort(QObject *parent)
    : QObject{parent}
{

    //数据初始化，四个字节的初值为0x06
    allBytesData.resize(4);
    allBytesData.fill(0x06);

    // 0: 上下           串口字节1控制
    // 1: 左右			串口字节2控制

    //当前位为1时，代表打开
    //半速设置				串口字节3第1位控制
    //反向开关				串口字节3第2位控制
    //滚刷开关				串口字节3第3位控制
    //LED开关				串口字节3第4位控制
    //串口状态				串口字节3第5位控制

    //定时向串口发送数据
    connect(&timer, &QTimer::timeout, this,&SerialPort::writeAllBytesData);

}

QStringList SerialPort::getSerialPortList()
{

    QStringList portNamesList;
    QList<QSerialPortInfo> availablePorts = QSerialPortInfo::availablePorts();

    // 遍历并打印所有可用串口的信息
    for (const QSerialPortInfo &port : availablePorts) {
        portNamesList.append(port.portName());
    }
    return portNamesList;
}

QList<qint32> SerialPort::getStandardBaudRates()
{
    QList<qint32> baudRates = QSerialPortInfo::standardBaudRates();
    return baudRates;

}

void SerialPort::setBytesData(int BytesNum, char BytesData)
{
    allBytesData[BytesNum] = static_cast<char>(BytesData);
}

char SerialPort::getBytesData(int BytesNum)
{
    return allBytesData[BytesNum];
}

//打开串口
void SerialPort::openSerialPort(QString PortName)
{

    //设置串口参数
    m_serialPort.setPortName(PortName); // 设置串口名字，根据实际情况修改
    m_serialPort.setBaudRate(QSerialPort::Baud115200); // 设置波特率
    m_serialPort.setDataBits(QSerialPort::Data8); // 设置数据位
    m_serialPort.setParity(QSerialPort::NoParity); // 设置校验位
    m_serialPort.setStopBits(QSerialPort::OneStop); // 设置停止位
    m_serialPort.setFlowControl(QSerialPort::NoFlowControl); // 设置流控制模式


    if (m_serialPort.open(QSerialPort::ReadWrite)) {
        qDebug("打开串口成功");
        //读取数据
        connect(&m_serialPort, &QSerialPort::readyRead, this, &SerialPort::readData);

        //发送数据给机器人
        // connect(&timer, &QTimer::timeout, this,&SerialPort::writeAllBytesData);

        //每过100毫秒向发送一次数据到机器人
        timer.start(10);

    } else {
        qDebug("串口打开失败");
    }
}

//关闭串口
void SerialPort::closeSerialPort()
{
    if(m_serialPort.isOpen()){
        // 先写入一次数据
        writeAllBytesData();

        if (m_serialPort.waitForBytesWritten(-1)) {

            //接收到数据，运行读取串口数据
            QObject::disconnect(&m_serialPort, &QSerialPort::readyRead, this, &SerialPort::readData);
            // QObject::disconnect(&timer, &QTimer::timeout, this,&SerialPort::writeAllBytesData);

            //停止定时器
            timer.stop();
            qDebug("c++关闭串口");
            //关闭串口
            m_serialPort.close();

        }
        timer.stop();
    }
}


//读取机器人发送过来的数据
void SerialPort::readData()
{
    if (m_serialPort.isOpen()){
        //能够读取数据
        emit canReadData();

        //获取数据
        // QByteArray data = m_serialPort.readLine(); // 假设data是一个const QByteArray对象
        // QString str = QString::fromUtf8(data); // 使用fromUtf8()函数将data转换为QString

        // QVector<uint32_t> speeds(4);
        // int index = 0;
        // // 解析数据

        // QStringList values = str.split(' '); // 假设数据之间用空格分隔

        // if(values.length()==5){
        //     qDebug()<<values;
        //     // qDebug()<<str;
        //     return;
        // }

        QByteArray data = m_serialPort.readAll();
        if (data.length() != 20){
            qDebug() << "长度错误";
            return;
        }

        int  outIntVar[5];
        memcpy(&outIntVar, data.data(), 20);

        int sumNumber = outIntVar[0] + outIntVar[1] + outIntVar[2] + outIntVar[3];
        if (sumNumber != outIntVar[4]){
            qDebug() << "校验错误";
            return;
        }

        qDebug() << outIntVar;

        // int a = outIntVar[0] / 4 - outIntVar[1] / 4 + outIntVar[2] / 4 - outIntVar[3] / 4;
        // if(outIntVar[0] >= 0){
        //     a = 1;
        // }else{
        //     a = -1;
        // }

        outIntVar[0] =  outIntVar[0];
        outIntVar[1] =  outIntVar[1];
        outIntVar[2] =  -outIntVar[2];
        outIntVar[3] =  -outIntVar[3];


        QStringList values = {QString::number(outIntVar[0]),QString::number(outIntVar[1]),QString::number(outIntVar[2]),QString::number(outIntVar[3])};



        // qDebug() << values;
        // for (const QString &value : values) {
        //    // bool ok;
        //    // int intValue = value.toInt();

        //    // qDebug("%d",intValue);
        //    // if (ok && index < speeds.size()) {
        //    //     speeds[index] = intValue;
        //    //     index++;
        //    // }
        // }
        emit motorSpeedUpdated(values);

        // //获取数据
        // QVector<uint32_t> speeds(4);
        // QByteArray data = m_serialPort.readLine(); // 假设data是一个const QByteArray对象
        // qDebug() <<data;

        // for (int i = 0; i < data.size(); i += 4) {
        //    uint32_t value = static_cast<uint32_t>(data[i]) |
        //                     static_cast<uint32_t>(data[i + 1]) << 8 |
        //                     static_cast<uint32_t>(data[i + 2]) << 16 |
        //                     static_cast<uint32_t>(data[i + 3]) << 24;
        //    // qDebug() << value;
        //    speeds[i/4] = value;
        // }
        // emit motorSpeedUpdated(speeds);

        // //获取数据
        // QByteArray data = m_serialPort.readLine();
        // QVector<uint32_t> speeds(4);
        // // 确保数据长度足够
        // while (data.size() >= sizeof(int32_t) * 4) {
        //     int32_t motorSpeed[4];

        //     // 从数据中提取四个int32_t值
        //     memcpy(motorSpeed, data.data(), sizeof(motorSpeed));
        //     // 在这里处理motorSpeed值...
        //     qDebug() << "Motor speeds:" << motorSpeed[0] << motorSpeed[1] << motorSpeed[2] << motorSpeed[3];
        //     // 移除已处理的数据

        //     for (int var = 0; var < 4; ++var) {
        //         speeds[var] = motorSpeed[var];
        //     }

        //     data.remove(0, sizeof(motorSpeed));
        // }
        // emit motorSpeedUpdated(speeds);
    }

}


//发送数据到机器人
void SerialPort::writeAllBytesData()
{
    if (m_serialPort.isOpen()){
        //发送数据到机器人
        // qDebug()<<"send";
        m_serialPort.write(allBytesData+'\n');
    }
}
