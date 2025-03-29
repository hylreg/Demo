import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
// import Qt.labs.settings
import QtCore


import CtrlApp 1.0
import QtQuick.Controls.Material 2.5


Item {
    id: loginPage
    anchors.fill: parent

    property string savedPassword: ""

    Material.theme: Material.Light
    Material.accent: Material.LightBlue



    //账号密码存储
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
        //设置初始密码，及初始状态
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


    //登陆界面图像
    Image {
        id: name
        anchors.fill: parent
        source: "qrc:/material/bj1.jpg"
        // source: "qrc:/"
    }


    //标题
    Text {
        text:"机器人控制系统"
        id:titleBox
        padding: 10
        color: "white"
        font.bold: true
        font.pixelSize: 20
        font.italic: true

    }



    //渐变背景
    Rectangle{
        width: parent.width
        height: parent.height-titleBox.height
        anchors.top: titleBox.bottom

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#8d9bae" } // 渐变开始颜色（顶部）
            GradientStop { position: 1.0; color: "#b2bac7" } // 渐变结束颜色（底部）
        }

    }

    Item {
        id:imageItem
        width: parent.width - loginRect.width // 根据需要调整
        height: parent.height / 4 * 3
        anchors.top: titleBox.bottom

        property int margin: 10

        Image {
            id: loginImg
            source: "qrc:/material/loginImg.png"
            anchors.fill: parent
            anchors.margins: parent.margin // 使用容器的margin属性
        }
    }

    Item{
        id:loginRect
        anchors.left: imageItem.right
        anchors.top: imageItem.top
        width: 300
        anchors.margins: 10
        height: loginBox.height+50


        Rectangle{
            width: parent.width*0.8
            height: parent.height
            color: "transparent" // 设置背景透明
            border.color: "black" // 边框颜色
            border.width: 3 // 边框宽度
            radius: 10

            RowLayout {
                    id:loginBox
                    anchors.centerIn: parent
                    ColumnLayout {

                        RowLayout {

                            Label {
                                id: accountLabel
                                text: "账号："
                            }
                            ComboBox {
                                id: accountComboBox
                                editable: true
                                Layout.fillWidth: true
                                //用户名
                                model: ["Admin001", "Admin002"]


                                onCurrentIndexChanged: {
                                    //判断当前是哪个用户
                                    if(accountComboBox.currentIndex === 0){
                                        //是否记住密码
                                        rememberCheckbox.checked = admin001.isRemember
                                        if(admin001.isRemember){
                                            //加载密码
                                            passwordField.text = admin001.password
                                        }else{
                                            passwordField.text = ""
                                        }
                                    }
                                    if(accountComboBox.currentIndex === 1){
                                        rememberCheckbox.checked = admin002.isRemember
                                        if(admin002.isRemember){
                                            passwordField.text = admin002.password
                                        }else{
                                            passwordField.text = ""
                                        }
                                    }
                                }

                                Component.onCompleted: {
                                    console.log(admin.lastUser)
                                    accountComboBox.currentIndex = admin.lastUser
                                }
                            }
                        }

                        RowLayout {
                            Label {
                                text: "密码："
                            }
                            TextField {
                                id: passwordField
                                placeholderText: "请输入密码"
                                echoMode: TextInput.Password
                                Layout.fillWidth: true

                                Component.onCompleted: {
                                    if(admin.lastUser === 0 && admin001.isRemember){
                                        passwordField.text = admin001.password
                                    }
                                    if(admin.lastUser === 1 && admin002.isRemember){
                                        passwordField.text = admin002.password
                                    }
                                }
                            }
                        }

                        RowLayout {

                            CheckBox {
                                id: rememberCheckbox
                                text: "记住密码"
                                checked: savedPassword !== "" ? true : false

                                Component.onCompleted: {
                                    if(admin.lastUser === 0){
                                        //是否记住密码
                                        rememberCheckbox.checked = admin001.isRemember
                                    }
                                    if(admin.lastUser === 1){
                                        rememberCheckbox.checked = admin002.isRemember
                                    }

                                }


                            }
                        }

                    Button {
                        Layout.alignment: Qt.AlignHCenter

                        text: " 登  录 "
                        onClicked: {
                            var account = accountComboBox.currentText
                            var password = passwordField.text
                            console.log(account,password)

                            if (account === "Admin001" && password === admin001.password ){
                                // 记录本次登录的用户
                                admin.setValue("lastUser",0)
                                admin.setValue("currentUser",0)
                                admin001.setValue("isRemember",rememberCheckbox.checked)

                                //页面跳转
                                pageLoader.sourceComponent = operatePage

                            }else if (account === "Admin002" && password === admin002.password){
                                admin.setValue("lastUser",1)
                                admin.setValue("currentUser",1)
                                admin002.setValue("isRemember",rememberCheckbox.checked)
                                pageLoader.sourceComponent = operatePage

                            }
                            else {
                                // 登录失败，显示错误提示
                                console.log("登录失败")
                                showLoginError()

                            }
                        }
                    }
                }
            }
        }
    }


    //密码提示框
    Dialog {
        id: dialog
        title: "错误提示"

        anchors.centerIn: parent

        Text{
            text: "账号或密码错误! "
        }
        standardButtons: Dialog.Ok
    }

    function showLoginError() {
        dialog.open()
    }
}
