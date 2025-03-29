#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <serialport.h>
#include <QQmlContext>
#include <QThread>
#include <portcontroller.h>
#include <QSettings>



int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    app.setOrganizationName("Some Company");
    app.setOrganizationDomain("somecompany.com");
    app.setApplicationName("Amazing Application");

    QQmlApplicationEngine engine;

    // SerialPort serialPort;
    // engine.rootContext()->setContextProperty("serialPort", &serialPort);



    // 创建 SerialPort 对象
    SerialPort* serialPort = new SerialPort;

    // // 创建一个新线程
    // QThread* thread = new QThread;

    // 将 serialPort 移动到新线程
    // serialPort->moveToThread(thread);

    PortController *portController = new PortController;     // 创建接收信号的对象
    // 连接信号与槽
    QObject::connect(serialPort, &SerialPort::canReadData,portController, &PortController::canReadDataSlots);
    QObject::connect(serialPort, &SerialPort::motorSpeedUpdated,portController, &PortController::updateQmlSlots);


    // QTimer timer;
    // QObject::connect(&timer, &QTimer::timeout, serialPort, &SerialPort::writeAllBytesData);
    // timer.start(100); // 设置定时器每隔10毫秒触发一次


    // 将 serialPort 对象暴露给 QML
    engine.rootContext()->setContextProperty("serialPort", serialPort);
    engine.rootContext()->setContextProperty("portController", portController);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("CtrlApp", "Main");

    // // 启动线程
    // thread->start();

    // // 确保应用程序退出时，线程能够正确地清理和退出
    // QObject::connect(&app, &QGuiApplication::aboutToQuit, thread, [&]() {
    //     thread->quit();
    //     thread->wait();
    //     delete serialPort;
    //     serialPort = nullptr;
    //     thread->deleteLater();
    // });

    return app.exec();
}
