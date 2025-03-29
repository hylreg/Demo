import QtQuick
import QtQuick.Controls 6.5
import QtQuick.Controls.Material 2.5
import QtQuick.Layouts


Item {
    property int btnFontSize: 15
    property string btnText: ""
    property string imageSource1: ""
    property string imageSource2: ""

    property alias ctrlSwitch: halfSpeed

    Material.theme: Material.Light // 使用Material主题
    Material.accent: Material.LightBlue // 设置主题的强调色（影响选中项颜色）

    ColumnLayout {
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        Row{
            width: halfSpeed.width
            anchors.horizontalCenter: halfSpeed.horizontalCenter

            Image {
                id:t5
                width: ctrlFontSize
                height: ctrlFontSize
                source: "file:../CtrlApp/素材/快下速度.png"
            }

            Label{
                id:halfSpeedLabel
                text: "半 速"
                leftPadding: 5
                font.pixelSize : ctrlFontSize
                anchors.verticalCenter: t5.verticalCenter

            }
        }
        Switch {
            id:halfSpeed

            checked: false
            enabled: masterSwitch.checked

            onCheckedChanged: {
                var str = "半速："+halfSpeed.checked+'\n'
                // serialPort.writeData(str)
                if(checked){
                    serialPort.setBytesData(2,serialPort.getBytesData(2)|0x80)
                }else{
                    serialPort.setBytesData(2,serialPort.getBytesData(2)&0x7F)
                }

                serialPort.writeAllBytesData();

            }
        }
    }


    // ColumnLayout {
    //     id: column
    //     anchors.fill: parent

    //     Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter


    //     Row {
    //         id: row
    //         height: label1.height
    //         anchors.horizontalCenter: switch1.horizontalCenter

    //         Image {
    //             id: image
    //             width: label1.height
    //             height: label1.width
    //             source: imageSource1
    //             fillMode: Image.PreserveAspectFit
    //         }

    //         Label {
    //             id: label1
    //             text: btnText
    //             anchors.verticalCenter: image.verticalCenter
    //             leftPadding: 5
    //             font.pixelSize: btnFontSize
    //         }
    //     }

    //     Switch {
    //         id: switch1
    //         checked: false
    //         // enabled: masterSwitch.checked
    //     }
    // }



}


