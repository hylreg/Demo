
import QtQuick
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

import QtQuick.Controls.Material 2.5


//最先运行的界面

/*常用修改
width: 200 控件宽
height: 200 控件高
color: status?"green":"red" 颜色
text: "机器：" + (status?"开启":"待机") 文本显示
topPadding: 5 修改顶部间隔
leftPadding: 15 修改左部间隔
rightPadding: 15 修改右部间隔
bottomPadding: 5 修改底部间隔
font.pixelSize 20 修改字体大小
source: "file:../material/loginImg.png" 修改图像
*/






Window {
    width: 920
    height: 640
    visible: true
    title: qsTr("机器人控制系统")

    //窗口最大最小设置
    minimumWidth: 920
    minimumHeight: 640
    // maximumWidth: 800
    // maximumHeight: 640

    Material.theme: Material.Light // 使用Material主题
    Material.accent: Material.Blue // 设置主题的强调色（影响选中项颜色）


    //改主页面的背景颜色
    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "lightblue" } // 渐变开始颜色（顶部）
            GradientStop { position: 1.0; color: "darkblue" } // 渐变结束颜色（底部）
        }
    }

    //页面加载
    Loader { id: pageLoader
        anchors.fill: parent

        //登录页面
        Component{
            id:loginPage
            LoginPage{
            }
        }

        //操作页面
        Component{
            id:operatePage
            OpPage{
                anchors.centerIn: parent
            }
        }
    }

    Component.onCompleted:pageLoader.sourceComponent = loginPage

}
