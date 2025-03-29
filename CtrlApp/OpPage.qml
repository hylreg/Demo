import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts
import QtQuick.Controls.Material 2.5
import QtCore


Item {
    id: rectangle
    anchors.fill: parent

    Material.theme: Material.Light // 使用Material主题
    Material.accent: Material.LightBlue // 设置主题的强调色（影响选中项颜色）

    //初始信息加载
    Settings{
        id:admin
        category: "admin"
        property int lastUser: 0
        property int currentUser: 0

    }
    Settings{
        id:admin001
        category: "admin001"
        property string account: "Admin001"
        //账户初始密码
        property string password: "Admin001"
        property bool isRemember: false

        property bool isOpenLights: false
        property bool isOpenBrush: false

        property bool reverse: false
        property bool halfSpeed: false
        property bool activate: false
        property int pressTheSpeed: 40
        property bool speedTheHold :false

    }
    Settings{
        id:admin002
        category: "admin002"
        property string account: "Admin002"
        property string password: "Admin002"
        property bool isRemember: false


        property bool isOpenLights: false
        property bool isOpenBrush: false

        property bool reverse: false
        property bool halfSpeed: false
        property bool activate: false
        property int pressTheSpeed: 40
        property bool speedTheHold :false


    }

    property int ctrlFontSize: 15

    //顶部图片
    Image {
        id: name
        anchors.fill: parent
        source: "qrc:/material/bj1.jpg"
    }

    Item {
        id: titleItem
        height: tabBar.height
        width: parent.width

        Row{

            // 标题
            Text {
                id:titleText
                text:"机器人控制系统"
                leftPadding: 10
                rightPadding: 20
                color: "white"
                font.bold: true
                font.pixelSize: 20
                font.italic: true
                anchors.verticalCenter: tabBar.verticalCenter
            }

            //导航栏按键
            TabBar {
                id: tabBar
                background: Item {
                    Rectangle {
                        anchors.fill: parent
                        color: "transparent"  // 设置背景颜色为透明
                    }
                }



                TabButton {
                    text: "用 户 操 作"
                    font.pixelSize: 15

                }
                TabButton {
                    text: "用 户 管 理"
                    font.pixelSize: 15
                }

            }
        }

    }

    //切换界面
    StackLayout {
                id: stackLayout
                width: parent.width
                height: parent.height-titleItem.height
                anchors.top: titleItem.bottom
                currentIndex: tabBar.currentIndex

                //用户操作界面
                ColumnLayout {
                    id: column
                    width: parent.width
                    height: display.height
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                    spacing: 1

                    //数据显示区域
                    Rectangle {
                        id:display
                        Layout.fillWidth: true
                        height: speed.height+10
                        color: "#e4ebf5"

                        ColumnLayout{
                            id:speed
                            width: parent.width
                            Item {
                                width: parent.width
                                height: 5
                            }


                            //机器人显示状态区域
                            Rectangle{
                                id:dispalyArea
                                width: displayLabel.width
                                height: stateDisplay.height
                                Layout.alignment: Qt.AlignHCenter
                                radius: 5
                                anchors.topMargin: 5  // 向下偏移 5 个像素
                                color: "#ffffff"

                                ColumnLayout{
                                    id:stateDisplay
                                    width: parent.width
                                    Label{
                                        id:roboot
                                        Layout.alignment: Qt.AlignHCenter
                                        text: "机 器 人 状 态"
                                        font.pixelSize: 15
                                        topPadding: 10
                                    }
                                    GridLayout{
                                        layoutDirection: Qt.LeftToRight
                                        flow: Grid.LeftToRight
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                        columns: 2
                                        rows: 2

                                        Label{
                                            id:speedLF
                                            Layout.fillWidth: true
                                            topPadding: 10
                                            bottomPadding: 10
                                            font.pixelSize : ctrlFontSize
                                            height: Label.height

                                            Label{
                                                id:speedLF1
                                                anchors.centerIn: parent
                                                text: "左前轮："+"0"
                                            }
                                        }

                                        Label{
                                            id:speedRF
                                            Layout.fillWidth: true
                                            topPadding: 10
                                            bottomPadding: 10
                                            font.pixelSize : ctrlFontSize
                                            height: Label.height

                                            Label{
                                                id:speedRF1
                                                anchors.centerIn: parent
                                                text: "右前轮："+"0"
                                            }
                                        }

                                        Label{
                                            id:speedLB
                                            Layout.fillWidth: true
                                            topPadding: 10
                                            bottomPadding: 10
                                            font.pixelSize : ctrlFontSize
                                            height: Label.height


                                            Label{
                                                id:speedLB1
                                                anchors.centerIn: parent
                                                text: "左后轮："+"0"
                                            }

                                        }
                                        Label{
                                            id:speedRB
                                            Layout.fillWidth: true
                                            topPadding: 10
                                            bottomPadding: 10
                                            font.pixelSize : ctrlFontSize
                                            height: Label.height


                                            Label{
                                                id:speedRB1
                                                anchors.centerIn: parent
                                                text: "右后轮："+"0"
                                            }

                                        }
                                    }

                                }

                            }

                            //机器人状态区域
                            Rectangle{

                                width: displayLabel.width
                                color: "#ffffff"

                                height: displayLabel.height
                                Layout.alignment: Qt.AlignHCenter
                                radius: 5

                                RowLayout{
                                    id:displayLabel

                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                    Label{
                                        id:machineStatus
                                        property bool status: false

                                        //根据状态改变颜色
                                        color: status?"green":"red"
                                        text: "机器：" + (status?"开启":"待机")
                                        topPadding: 5
                                        leftPadding: 15
                                        rightPadding: 15
                                        bottomPadding: 5
                                        font.pixelSize : ctrlFontSize

                                    }

                                    Label{
                                        color: halfSpeed.checked?"green":"red"
                                        text: "半速："+ (halfSpeed.checked?"开启":"关闭")
                                        topPadding: 10
                                        leftPadding: 20
                                        rightPadding: 20
                                        bottomPadding: 10
                                        font.pixelSize : ctrlFontSize


                                    }
                                    Label{
                                        color: reverse.checked?"green":"red"
                                        text: "反向："+ (reverse.checked?"开启":"关闭")
                                        topPadding: 10
                                        leftPadding: 20
                                        rightPadding: 20
                                        bottomPadding: 10
                                        font.pixelSize : ctrlFontSize

                                    }

                                    Label{
                                        color: lights.checked?"green":"red"
                                        text: "前灯："+ (lights.checked?"开启":"关闭")
                                        topPadding: 10
                                        leftPadding: 20
                                        rightPadding: 20
                                        bottomPadding: 10
                                        font.pixelSize : ctrlFontSize


                                    }
                                    Label{
                                        color: brush.checked?"green":"red"
                                        text: "滚刷："+ (brush.checked?"开启":"关闭")
                                        topPadding: 10
                                        leftPadding: 20
                                        rightPadding: 20
                                        bottomPadding: 10
                                        font.pixelSize : ctrlFontSize
                                    }
                                }
                            }
                        }
                    }

                    //控制区域
                    Item{
                        width: parent.width
                        Layout.fillWidth: true
                        Layout.fillHeight: true


                        RowLayout{
                            anchors.fill: parent
                            spacing: 1

                            Rectangle {
                                id:control
                                color: "#e4ebf5"
                                width: 200
                                Layout.fillHeight: true

                                RowLayout {
                                    id: row
                                    anchors.fill: parent

                                    Item {

                                        Layout.fillWidth: true // 填充父元素的宽度
                                        Layout.fillHeight: true // 填充父元素的宽度

                                        ColumnLayout{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter

                                            Switch {
                                                id:serialPortSwitch
                                                checked: false
                                                visible: false
                                            }

                                            Image {
                                                width: 80
                                                height: 80
                                                fillMode: Image.PreserveAspectFit
                                                source: serialPortSwitch.checked?"qrc:/material/电源.png":"qrc:/material/电源 (1).png"
                                                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop

                                                //设置可点击区域
                                                MouseArea {
                                                    anchors.fill: parent
                                                    onClicked:{
                                                        if(!serialPortSwitch.checked){
                                                            console.log("qml:打开串口")
                                                            //串口开关置为打开
                                                            serialPortSwitch.checked = true

                                                            //改变方向键透明度
                                                            upBtn.opacity = 1
                                                            downBtn.opacity=1
                                                            leftBtn.opacity=1
                                                            rightBtn.opacity=1

                                                            //初始化机器人速度、状态，标记串口为打开
                                                            serialPort.setBytesData(0,0x64)
                                                            serialPort.setBytesData(1,0x64)
                                                            serialPort.setBytesData(2,0x07)
                                                            serialPort.openSerialPort(portComboBox.currentValue)

                                                        }else{
                                                            console.log("qml:关闭串口")

                                                            machineStatus.status = false

                                                            //界面开关置为关闭
                                                            serialPortSwitch.checked = false
                                                            lights.checked = false
                                                            brush.checked = false
                                                            halfSpeed.checked = false
                                                            reverse.checked = false

                                                            speedLF1.text = "左前轮：0 "
                                                            speedRF1.text = "右前轮：0 "
                                                            speedLB1.text = "左后轮：0 "
                                                            speedRB1.text = "右后轮：0 "


                                                            //机器人速度、状态置为初始值，标记串口关闭
                                                            serialPort.setBytesData(0,0x64)
                                                            serialPort.setBytesData(1,0x64)
                                                            serialPort.setBytesData(2,0x06)
                                                            // serialPort.writeAllBytesData();

                                                            //改变方向键透明度
                                                            upBtn.opacity = 1
                                                            downBtn.opacity=1
                                                            leftBtn.opacity=1
                                                            rightBtn.opacity=1

                                                            //关闭串口
                                                            serialPort.closeSerialPort()
                                                        }
                                                    }
                                                }
                                            }

                                            Row{
                                                width: serialPortSwitch.width
                                                Layout.alignment: Qt.AlignHCenter

                                                Label{
                                                    leftPadding: 5
                                                    text: "串口开关"
                                                    font.pixelSize : ctrlFontSize
                                                    anchors.verticalCenter: parent.verticalCenter
                                                }
                                            }

                                            Item {
                                                width: parent.width
                                                height: 10
                                            }



                                            Row{
                                                Image {
                                                    width: Label.height
                                                    height: Label.width
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    source: "qrc:/material/COM001.png"
                                                }


                                                Label {
                                                    id:portName
                                                    text: "串口选择："
                                                    verticalAlignment: Text.AlignVCenter
                                                    font.pixelSize : ctrlFontSize

                                                }
                                            }

                                            Rectangle{
                                                width: portComboBox.width
                                                height: portComboBox.height

                                                color: "transparent" // 设置背景透明

                                                ComboBox {
                                                    id: portComboBox
                                                    width: pressSpeed.width
                                                    enabled: !serialPortSwitch.checked



                                                    Component.onCompleted: {
                                                        model = serialPort.getSerialPortList()
                                                    }

                                                }
                                            }


                                            Item {
                                                width: parent.width
                                                height: 10
                                            }


                                            Row{
                                                Image {
                                                    width: Label.height
                                                    height: Label.width
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    source: "qrc:/material/速度.png"
                                                }


                                                Label {
                                                    id:portName1
                                                    text: " 速度值："
                                                    verticalAlignment: Text.AlignVCenter
                                                    font.pixelSize : ctrlFontSize


                                                }
                                            }


                                            SpinBox {
                                                id:pressSpeed
                                                from: 0
                                                to: 80
                                                editable: true
                                                stepSize: 5
                                                value: 40

                                                onValueChanged: {
                                                    if(admin.lastUser === 0){
                                                        admin001.setValue("pressTheSpeed",pressSpeed.value)
                                                    }
                                                    if(admin.lastUser === 1 ){
                                                        admin002.setValue("pressTheSpeed",pressSpeed.value)

                                                    }
                                                }

                                                Component.onCompleted: {
                                                    if(admin.lastUser === 0){
                                                        pressSpeed.value = admin001.pressTheSpeed
                                                    }
                                                    if(admin.lastUser === 1 ){
                                                        pressSpeed.value = admin002.pressTheSpeed
                                                    }
                                                }

                                            }


                                            Rectangle{
                                                width: pressSpeed.width
                                                height: pressSpeed.height

                                                border.color: "#9f9f9f" // 边框颜色
                                                border.width: 1 // 边框宽度
                                                radius: 5 // 圆角半径
                                                color: "transparent" // 设置背景透明



                                                Row{
                                                    anchors.fill: parent
                                                    anchors.centerIn: parent

                                                    leftPadding: 20

                                                    Image {
                                                        width: 32
                                                        height: 32
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        source: speedHold.checked?"qrc:/material/开关 (1).png":"qrc:/material/开关.png"
                                                    }


                                                    Label {
                                                        text: " 速度保持"
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        font.pixelSize : ctrlFontSize
                                                    }
                                                }

                                                MouseArea{
                                                    anchors.fill: parent
                                                    onClicked: {
                                                        if(speedHold.checked){
                                                            speedHold.checked = false
                                                        }else{
                                                            speedHold.checked = true
                                                        }
                                                    }
                                                }

                                                Switch{
                                                    id:speedHold
                                                    checked: false
                                                    text: "速度保持"
                                                    font.pixelSize : ctrlFontSize
                                                    visible: false

                                                    anchors.verticalCenter: parent.verticalCenter


                                                    onCheckedChanged: {
                                                        if(admin.lastUser === 0){
                                                            admin001.setValue("speedTheHold",speedHold.checked)


                                                        }
                                                        if(admin.lastUser === 1 ){
                                                            admin002.setValue("speedTheHold",speedHold.checked)

                                                        }
                                                        upBtn.opacity = 1
                                                        downBtn.opacity=1
                                                        leftBtn.opacity=1
                                                        rightBtn.opacity=1

                                                        serialPort.setBytesData(0,0x64)
                                                        serialPort.setBytesData(1,0x64)
                                                    }

                                                }
                                            }

                                        }
                                    }
                                }
                            }

                            //方向控制
                            Rectangle{
                                    id:ctrlItem

                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    color: "#e4ebf5"

                                    Item{
                                        anchors.fill: parent

                                        Item{
                                            width: (parent.width>parent.height?parent.height:parent.width)*0.9
                                            height: (parent.width>parent.height?parent.height:parent.width)*0.9
                                            // color: "red"
                                            anchors.centerIn: parent
                                            MouseArea{
                                                anchors.fill: parent

                                                onClicked: {
                                                    // console.log("点击大区域")

                                                    //聚焦选中
                                                    keyCtrl.focus = true

                                                    upBtn.opacity = 1
                                                    downBtn.opacity=1
                                                    leftBtn.opacity=1
                                                    rightBtn.opacity=1

                                                    serialPort.setBytesData(0,0x64)
                                                    serialPort.setBytesData(1,0x64)
                                                }
                                            }


                                            //3*3网格布局
                                            Grid {
                                                columns: 3
                                                spacing: 3
                                                anchors.fill: parent
                                                flow: Grid.LeftToRight

                                                Item {
                                                    width: parent.width/3
                                                    height: parent.height/3
                                                }

                                                //上
                                                Rectangle {
                                                    id:upBtn
                                                    width: parent.width/3
                                                    height: parent.height/3
                                                    // color: "#4472c4"
                                                    color: "transparent" // 设置背景透明


                                                    Image {
                                                        anchors.centerIn: parent
                                                        anchors.fill: parent
                                                        id: name1
                                                        source: "qrc:/material/向上.png"

                                                        rotation: 0

                                                    }

                                                    // 该区域可以点击
                                                    MouseArea {
                                                        anchors.fill: parent

                                                        onPressed: {
                                                            // 初始值加上按键按下的速度值
                                                            serialPort.setBytesData(0,0x64+pressSpeed.value)
                                                            serialPort.setBytesData(1,0x64)

                                                            // 改变按键按下的透明度
                                                            parent.opacity = 0.5
                                                            upBtn.opacity = 0.5
                                                            downBtn.opacity=1
                                                            leftBtn.opacity=1
                                                            rightBtn.opacity=1
                                                        }
                                                        onReleased: {
                                                            //是否启用速度保持，不启用松开按键速度为0
                                                            if(!speedHold.checked){
                                                                serialPort.setBytesData(0,0x64)
                                                                serialPort.setBytesData(1,0x64)
                                                                parent.opacity = 1
                                                            }
                                                        }

                                                    }

                                                }
                                                Item {
                                                    width: parent.width/3
                                                    height: parent.height/3
                                                }
                                                //左
                                                Rectangle {
                                                    id:leftBtn
                                                    width: parent.width/3
                                                    height: parent.height/3

                                                    // color: "#4472c4"
                                                    color: "transparent" // 设置背景透明


                                                    Image {
                                                        anchors.centerIn: parent
                                                        anchors.fill: parent
                                                        id: name2
                                                        source: "qrc:/material/向上.png"

                                                        rotation: 270
                                                    }

                                                    MouseArea {
                                                        anchors.fill: parent
                                                        onPressed: {
                                                            serialPort.setBytesData(0,0x64)
                                                            serialPort.setBytesData(1,0x64-pressSpeed.value)
                                                            parent.opacity = 0.5

                                                            upBtn.opacity = 1
                                                            downBtn.opacity=1
                                                            leftBtn.opacity=0.5
                                                            rightBtn.opacity=1
                                                        }
                                                        onReleased: {
                                                            if(!speedHold.checked){
                                                                serialPort.setBytesData(0,0x64)
                                                                serialPort.setBytesData(1,0x64)
                                                                parent.opacity = 1
                                                            }
                                                        }
                                                    }
                                                }
                                                Item {
                                                    width: parent.width/3
                                                    height: parent.height/3
                                                }
                                                //右
                                                Rectangle {
                                                    id:rightBtn
                                                    width: parent.width/3
                                                    height: parent.height/3

                                                    // color: "#4472c4"
                                                    color: "transparent" // 设置背景透明


                                                    Image {
                                                        anchors.centerIn: parent
                                                        anchors.fill: parent
                                                        id: name3
                                                        source: "qrc:/material/向上.png"
                                                        rotation: 90
                                                    }

                                                    MouseArea {
                                                        anchors.fill: parent
                                                        onPressed: {
                                                            serialPort.setBytesData(0,0x64)
                                                            serialPort.setBytesData(1,0x64+pressSpeed.value)
                                                            parent.opacity = 0.5

                                                            upBtn.opacity = 1
                                                            downBtn.opacity=1
                                                            leftBtn.opacity=1
                                                            rightBtn.opacity=0.5
                                                        }
                                                        onReleased: {
                                                            if(!speedHold.checked){
                                                                serialPort.setBytesData(0,0x64)
                                                                serialPort.setBytesData(1,0x64)
                                                                parent.opacity = 1
                                                            }
                                                        }
                                                    }
                                                }
                                                Item {
                                                    width: parent.width/3
                                                    height: parent.height/3
                                                }
                                                //下
                                                Rectangle {
                                                    id:downBtn
                                                    width: parent.width/3
                                                    height: parent.height/3
                                                    // color: "#4472c4"
                                                    color: "transparent" // 设置背景透明


                                                    Image {
                                                        anchors.centerIn: parent
                                                        anchors.fill: parent
                                                        id: name4
                                                        source: "qrc:/material/向上.png"
                                                        rotation: 180
                                                    }

                                                    MouseArea {
                                                        anchors.fill: parent
                                                        onPressed: {
                                                            serialPort.setBytesData(0,0x64-pressSpeed.value)
                                                            serialPort.setBytesData(1,0x64)
                                                            parent.opacity = 0.5

                                                            upBtn.opacity = 1
                                                            downBtn.opacity=0.5
                                                            leftBtn.opacity=1
                                                            rightBtn.opacity=1
                                                        }
                                                        onReleased: {
                                                            if(!speedHold.checked){
                                                                serialPort.setBytesData(0,0x64)
                                                                serialPort.setBytesData(1,0x64)
                                                                parent.opacity = 1
                                                            }

                                                        }
                                                    }
                                                }
                                                Item {
                                                    width: parent.width/3
                                                    height: parent.height/3
                                                }

                                            }

                                        }


                                    }

                                    Item{
                                        id:keyCtrl
                                        focus: true

                                        //按键控制
                                        Keys.onPressed:(event)=>{
                                            if (event.key === Qt.Key_Up) {
                                                // 处理上箭头按键逻辑
                                                // console.log(0x64+pressSpeed.value)

                                                //修改速度数据
                                                serialPort.setBytesData(0,0x64+pressSpeed.value)
                                                serialPort.setBytesData(1,0x64)

                                                upBtn.opacity = 0.5
                                                downBtn.opacity=1
                                                leftBtn.opacity=1
                                                rightBtn.opacity=1

                                            } else if (event.key === Qt.Key_Down) {
                                                // 处理下箭头按键逻辑
                                                // console.log(0x64-pressSpeed.value)

                                                serialPort.setBytesData(0,0x64-pressSpeed.value)
                                                serialPort.setBytesData(1,0x64)
                                                               upBtn.opacity = 1
                                                               downBtn.opacity=0.5
                                                               leftBtn.opacity=1
                                                               rightBtn.opacity=1

                                            }else if (event.key === Qt.Key_Left) {
                                                // 处理左箭头按键逻辑
                                                // console.log(0x64-pressSpeed.value)


                                                serialPort.setBytesData(0,0x64)
                                                serialPort.setBytesData(1,0x64-pressSpeed.value)
                                                               upBtn.opacity = 1
                                                               downBtn.opacity=1
                                                               leftBtn.opacity=0.5
                                                               rightBtn.opacity=1
                                            } else if (event.key === Qt.Key_Right) {
                                                // 处理右箭头按键逻辑
                                                // console.log(0x64+pressSpeed.value)
                                                serialPort.setBytesData(0,0x64)
                                                serialPort.setBytesData(1,0x64+pressSpeed.value)
                                                               upBtn.opacity = 1
                                                               downBtn.opacity=1
                                                               leftBtn.opacity=1
                                                               rightBtn.opacity=0.5

                                            }
                                        }

                                        Keys.onReleased :(event)=>{
                                                            //如果勾选速度保持
                                                            if(speedHold.checked){
                                                                 if (event.key === Qt.Key_Up) {
                                                                     // 处理上箭头按键逻辑
                                                                     // console.log(0x64+pressSpeed.value)

                                                                     serialPort.setBytesData(0,0x64+pressSpeed.value)
                                                                     serialPort.setBytesData(1,0x64)

                                                                     upBtn.opacity = 0.5
                                                                     downBtn.opacity=1
                                                                     leftBtn.opacity=1
                                                                     rightBtn.opacity=1

                                                                 } else if (event.key === Qt.Key_Down) {
                                                                     // 处理下箭头按键逻辑
                                                                     // console.log(0x64-pressSpeed.value)
                                                                     serialPort.setBytesData(0,0x64-pressSpeed.value)
                                                                     serialPort.setBytesData(1,0x64)

                                                                     upBtn.opacity = 1
                                                                     downBtn.opacity=0.5
                                                                     leftBtn.opacity=1
                                                                     rightBtn.opacity=1

                                                                 }else if (event.key === Qt.Key_Left) {
                                                                     // 处理左箭头按键逻辑
                                                                     // console.log(0x64-pressSpeed.value)

                                                                     serialPort.setBytesData(0,0x64)
                                                                     serialPort.setBytesData(1,0x64-pressSpeed.value)
                                                                     upBtn.opacity = 1
                                                                     downBtn.opacity=1
                                                                     leftBtn.opacity=0.5
                                                                     rightBtn.opacity=1
                                                                 } else if (event.key === Qt.Key_Right) {
                                                                     // 处理右箭头按键逻辑
                                                                     // console.log(0x64+pressSpeed.value)
                                                                     serialPort.setBytesData(0,0x64)
                                                                     serialPort.setBytesData(1,0x64+pressSpeed.value)
                                                                     upBtn.opacity = 1
                                                                     downBtn.opacity=1
                                                                     leftBtn.opacity=1
                                                                     rightBtn.opacity=0.5

                                                                 }else{
                                                                     serialPort.setBytesData(0,0x64)
                                                                     serialPort.setBytesData(1,0x64)
                                                                     upBtn.opacity = 1
                                                                     downBtn.opacity=1
                                                                     leftBtn.opacity=1
                                                                     rightBtn.opacity=1
                                                                 }

                                                            }

                                                            else{
                                                                serialPort.setBytesData(0,0x64)
                                                                serialPort.setBytesData(1,0x64)
                                                                 upBtn.opacity = 1
                                                                 downBtn.opacity=1
                                                                 leftBtn.opacity=1
                                                                 rightBtn.opacity=1
                                                            }
                                        }
                                    }
                                }

                            //开关量控制
                            Rectangle{

                                color: "#e4ebf5"

                                width: 200
                                Layout.fillHeight: true

                                GridLayout {
                                    height: parent.height/2
                                    columns: 2
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter


                                    ColumnLayout {

                                        Row{
                                            width: halfSpeed.width
                                            Layout.alignment: Qt.AlignHCenter


                                            Image {
                                                id:halfSpeedImage
                                                width: ctrlFontSize
                                                height: ctrlFontSize
                                                source: "qrc:/material/快下速度.png"
                                            }

                                            Label{
                                                id:halfSpeedLabel
                                                text: "半 速"
                                                leftPadding: 5
                                                font.pixelSize : ctrlFontSize
                                                anchors.verticalCenter: halfSpeedImage.verticalCenter

                                            }
                                        }
                                        Switch {
                                            id:halfSpeed
                                            checked: false
                                            enabled: serialPortSwitch.checked
                                            onCheckedChanged: {
                                                // 设置状态量
                                                if(checked){
                                                    serialPort.setBytesData(2,serialPort.getBytesData(2)|0x80)
                                                }else{
                                                    serialPort.setBytesData(2,serialPort.getBytesData(2)&0x7F)
                                                }

                                                keyCtrl.focus=true
                                            }
                                        }
                                    }

                                    ColumnLayout{
                                        Row{
                                            width: reverse.width
                                            Layout.alignment: Qt.AlignHCenter

                                            Image {
                                                id:reverseImage

                                                width: ctrlFontSize
                                                height: ctrlFontSize
                                                source: "qrc:/material/交换反向.png"
                                            }
                                            Label{
                                                text: "反 向"
                                                leftPadding: 5
                                                font.pixelSize : ctrlFontSize
                                                anchors.verticalCenter: reverseImage.verticalCenter
                                            }
                                        }
                                        Switch {
                                            id:reverse
                                            checked: false
                                            enabled: serialPortSwitch.checked

                                            onCheckedChanged: {
                                                if(checked){
                                                    serialPort.setBytesData(2,serialPort.getBytesData(2)|0x40)
                                                }else{
                                                    serialPort.setBytesData(2,serialPort.getBytesData(2)&0xBF)
                                                }
                                                keyCtrl.focus=true
                                            }

                                        }
                                    }

                                    ColumnLayout{
                                        Row{
                                            width: lights.width
                                            Layout.alignment: Qt.AlignHCenter

                                            Image {
                                                id:lightsImage
                                                width: ctrlFontSize
                                                height: ctrlFontSize
                                                source: "qrc:/material/前灯.png"
                                            }
                                            Label{
                                                id:lightsLabel
                                                text: "前 灯"
                                                leftPadding: 5
                                                font.pixelSize : ctrlFontSize
                                                anchors.verticalCenter: lightsImage.verticalCenter
                                            }
                                        }
                                        Switch {
                                            id:lights
                                            checked: false
                                            enabled: serialPortSwitch.checked


                                            //写入状态
                                            onCheckedChanged: {
                                                if(checked){
                                                    serialPort.setBytesData(2,serialPort.getBytesData(2)|0x10)
                                                }else{
                                                    serialPort.setBytesData(2,serialPort.getBytesData(2)&0xEF)
                                                }
                                                keyCtrl.focus=true
                                            }
                                        }
                                    }

                                    ColumnLayout{
                                        Row{
                                            width: brush.width
                                            Layout.alignment: Qt.AlignHCenter
                                            Image {
                                                id:brushImage
                                                width: ctrlFontSize
                                                height: ctrlFontSize
                                                source: "qrc:/material/滚刷.png"
                                            }
                                            Label{
                                                id:brushLabel
                                                text: "滚 刷"
                                                leftPadding: 5
                                                font.pixelSize : ctrlFontSize
                                                anchors.verticalCenter: brushImage.verticalCenter
                                            }
                                        }
                                        Switch {
                                            id:brush
                                            checked: false
                                            enabled: serialPortSwitch.checked


                                            onCheckedChanged: {

                                                //写入状态
                                                if(checked){
                                                    serialPort.setBytesData(2,serialPort.getBytesData(2)|0x20)
                                                }else{
                                                    serialPort.setBytesData(2,serialPort.getBytesData(2)&0xDF)
                                                }

                                                keyCtrl.focus=true
                                            }

                                        }
                                    }

                                }

                            }

                    }

                    }
                }

                //用户管理界面
                Rectangle{
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    // color: "#4472c4"
                    color: "#e4ebf5"

                    Rectangle{
                        anchors.centerIn: parent
                        width: userColumn.width+150
                        height: userColumn.height+100

                        border.color: "black"     // 边框颜色
                        border.width: 3           // 边框宽度
                        radius: 10
                        // color: "#4472c4"
                        color: "transparent" // 设置背景透明


                        ColumnLayout{
                            id:userColumn
                            spacing: 20

                            anchors.centerIn: parent

                            Rectangle{
                                width: currentUserText.width
                                height: currentUserText.height
                                radius: 5

                                // opacity: 0.8

                                Text {
                                    id: currentUserText
                                    text: "当 前 用 户: AdminXXX"
                                    font.pixelSize: 20
                                    padding: 15
                                    Component.onCompleted: {
                                        if(admin.lastUser===0){
                                            currentUserText.text = "当 前 用 户: Admin001"
                                        }else{
                                            currentUserText.text = "当 前 用 户: Admin002"
                                        }
                                    }
                                }
                            }
                            Item{
                                width: currentUserText.width
                                height: currentUserText.height

                                RowLayout{
                                    anchors.fill: parent


                                    Button {
                                        id: changePasswordButton
                                        text: "修改密码"
                                        Layout.alignment: Qt.AlignLeft // 左对齐

                                        onClicked: {
                                            // 打开修改密码对话框
                                            passwordDialog.open()
                                        }

                                    }

                                    // 退出登录按钮
                                    Button {
                                        id: logoutButton
                                        text: "退出登录"
                                        Layout.alignment: Qt.AlignRight // 右对齐

                                        onClicked: {
                                            // 在这里添加退出登录的逻辑
                                            serialPortSwitch.checkable=false
                                            halfSpeed.checked = false
                                            reverse.checked = false
                                            lights.checked = false
                                            brush.checked = false

                                            speedLF1.text = "左前轮：0 rad/s"
                                            speedRF1.text = "右前轮：0 rad/s"
                                            speedLB1.text = "左后轮：0 rad/s"
                                            speedRB1.text = "右后轮：0 rad/s"


                                            // 写入关闭状态
                                            serialPort.setBytesData(0,0x64)
                                            serialPort.setBytesData(1,0x64)
                                            serialPort.setBytesData(2,0x06)
                                            serialPort.writeAllBytesData();


                                            //关闭串口
                                            serialPort.closeSerialPort()

                                            // 页面跳转
                                            pageLoader.source = "LoginPage.qml";

                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

    //对话框
    Dialog {
        id: passwordDialog
        title: "修改密码"
        standardButtons: Dialog.Ok | Dialog.Cancel
        anchors.centerIn: parent

        Row {
            spacing: 10

            TextField {
                id: oldPasswordField
                placeholderText: "旧密码"
                echoMode: TextInput.Password
                Layout.fillWidth: true
            }

            TextField {
                id: newPasswordField
                placeholderText: "新密码"
                echoMode: TextInput.Password
                Layout.fillWidth: true
            }
        }

        onAccepted: {
            var oldPassword = oldPasswordField.text
            var newPassword = newPasswordField.text
            oldPasswordField.text = ''
            newPasswordField.text=''

            if(admin.lastUser===0){
                if(admin001.password===oldPassword){
                    admin001.setValue("password",newPassword)
                    console.log("密码已修改")
                    showModifySuccess()

                }
                else{
                    console.log("旧密码错误")
                    showModifyError()
                }
            }else{
                if(admin002.password===oldPassword){
                    admin002.setValue("password",newPassword)
                    console.log("密码已修改")
                    showModifySuccess()
                }
                else{
                    console.log("旧密码错误")
                    showModifyError()
                }
            }

        }
    }

    Dialog {
        id: modifyPasswFailed
        title: "错误提示"
        anchors.centerIn: parent
        Text{
            text: "账号或密码错误! "
        }
        standardButtons: Dialog.Ok
    }

    function showModifyError() {
        modifyPasswFailed.open()
    }

    Dialog {
        id: modifyPasswSuccess
        title: "成功提示"
        anchors.centerIn: parent
        Text{
            text: "修改密码成功! "
        }
        standardButtons: Dialog.Ok
    }

    function showModifySuccess() {
        modifyPasswSuccess.open()
    }


    //从串口中获取到的数据
    Component.onCompleted: {

        function onUpdateQml(speeds) {
            // 在这里处理速度数据

            // console.log(speeds)

            // for(var i=0;i<4;i++){
            //     speeds[i] = Math.abs(speeds[i]);
            // }


            speedLF1.text = "左前轮："+speeds[0]
            speedRF1.text = "右前轮："+speeds[2]
            speedLB1.text = "左后轮："+speeds[1]
            speedRB1.text = "右后轮："+speeds[3]

        }

        portController.updateSpeeds.connect(onUpdateQml)

        function onIsMachineOn(machineState){
            machineStatus.status = machineState

            //机器状态为待机
            if(!machineStatus.status){

            }
        }

        portController.isMachineOn.connect(onIsMachineOn)

    }
}
