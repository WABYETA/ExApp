import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import "./"
Window {
    id: mainWindow
    objectName: "mainWindow"
    visible: true
    width: 450
    height: 600
    title: qsTr("QTQuick")
    readonly property bool inPortrait: mainWindow.width < mainWindow.height
    property int drawerCurrentIndex: 0
    Drawer {
        id: drawer
        width: parent.width/1.5;
        height: parent.height
        visible: false
        background: Rectangle{ color: "white"}
        contentItem: Column{
            Repeater{
                model: ["Home", "About"]
                Rectangle{
                    color: {
                        if (bar.currentIndex === index){
                            return "lightgrey"
                        }
                        if (drawerItemArea.pressed && bar.currentIndex !== index){
                            return "lightgrey"
                        } else{
                            return "white"
                        }
                    }
                    width: parent.width
                    height: parent.height/9
                    Rectangle{
                        id: drawerItemIcon
                        x: drawerItemIcon.x += 35
                        width: 40; height: parent.height
                        color: "transparent"
                        Image{
                            source: "./assets/"+modelData+"Icon.png"
                            width: 30
                            height: 30
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }
                    Text{
                        anchors.left: drawerItemIcon.right
                        anchors.verticalCenter: parent.verticalCenter
                        color: "black"
                        text: modelData
                        font.pixelSize: 13
                        font.bold: true
                        antialiasing: true
                    }
                    MouseArea{
                        id: drawerItemArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            drawerCurrentIndex = index;
                            bar.currentIndex = drawerCurrentIndex;
                            drawer.close();
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        id: top
        color: "#4d4dff"
        width: parent.width
        height: parent.height/12
        Rectangle{
            id: openDrawer
            radius: parent.height/2
            width: parent.height
            height: parent.height
            color: openDrawerArea.pressed ? "#6666ff" : "#4d4dff"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            Image {
                source: "./assets/ListIcon.png"
                width: parent.height*0.4
                height: parent.height*0.4
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        MouseArea{
            id: openDrawerArea
            anchors.fill: openDrawer
            onClicked: drawer.open();
        }
        Rectangle{
            width: parent.height*2
            height: parent.height
            color: "#4d4dff"
            anchors.left: openDrawer.right
            anchors.verticalCenter: parent.verticalCenter
            Text {
                text: qsTr("<br/><h2>QTQuick</h2>")
                color: "black"
                font.bold: true
                font.pixelSize: 14
                font.family: "Arial"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
            }
        }
        Rectangle{
            id: search
            width: parent.height*1.2
            height: parent.height
            color: openDrawerArea.pressed ? "#6666ff" : "#4d4dff"
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            Image {
                source: "./assets/searchIcon.png"
                width: parent.height*0.9
                height: parent.height*0.9
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
            }
        }

    }
    TabBar {
        anchors.top: top.bottom
        anchors.right: parent.right
        id: bar
        width: parent.width
        spacing: 0
        background: Rectangle{
            color: "#4d4dff"
        }
        Repeater{
            model: ["Home", "About"]
            TabButton {
                onClicked: paging.currentIndex = bar.currentIndex
                Rectangle{
                    anchors.fill: parent
                    color: bar.currentIndex == index ? "#6666ff" : "#4d4dff"
                }
                Text {
                    id: homeBarText
                    color: "black"
                    anchors.horizontalCenter: parent.horizontalCenter; anchors.verticalCenter: parent.verticalCenter
                    text: qsTr(modelData)
                    font.family: "Arial"; font.pixelSize: 13; font.bold: true
                    renderType: Text.NativeRendering
                    antialiasing: true
                }
                Rectangle{
                    visible: true  //bar.currentIndex == index ? true : false
                    color: "lightgrey"
                    anchors.bottom: parent.bottom
                    height: 2; width: parent.width
                }
            }
        }
    }
    StackLayout {
        id: paging
        anchors.top: bar.bottom
        anchors.right: bar.right
        width: bar.width
        height: parent.height
        currentIndex: bar.currentIndex
        Item {
            HomePage{
                id: homePage
                width: parent.width
                height: parent.height
            }
        }
        Item {
            About{
                id: inputFormPage
                width: parent.width
                height: parent.height
            }
        }
    }
}
