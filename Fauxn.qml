import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.12

Item {
    id: phoneObject

    property bool rotating: false
    property bool landscape: true

    property real lsAdjX: 0//5 * ratioX
    property real lsAdjY: menuHeight

    property real ratioX: (phoneObject.landscape ? phoneFrame.paintedHeight / 854 : phoneFrame.paintedWidth / 465) // Original Image Width
    property real ratioY: (phoneObject.landscape ? phoneFrame.paintedWidth / 465 : phoneFrame.paintedHeight / 854) // Original Image Height

    property real aspectX: phoneObject.landscape ? (phoneFrame.paintedHeight - phoneFrame.paintedWidth) / 2 * ratioX : 0
    property real aspectY: phoneObject.landscape ? (phoneFrame.paintedHeight - phoneFrame.paintedWidth) / 2 * ratioY : 0

    property real insetX: (phoneObject.landscape ? 82 * ratioX - aspectX - lsAdjX : 76 * ratioX) // Based on above dimensions+ratio
    property real insetY: (phoneObject.landscape ? 76 * ratioY + aspectY + lsAdjY: 76 * ratioY) // Based on above dimensions+ratio

    property real menuHeight: 28 * ratioY // Based on above dimensions+ratio
    property real controlsHeight: 39 * ratioY

    property real screenSizeX: (phoneObject.landscape ? 699 * ratioX + menuHeight : 340 * ratioX) // Based on above dimensions+ratio
    property real screenSizeY: (phoneObject.landscape ? 303 * ratioY - menuHeight : 660 * ratioY) // Based on above dimensions+ratio

    property real landscapeTop: (0 - (phoneObject.height * 0.10))
    property real portraitTop: (phoneObject.height * 0.2)
    property real myTopMargin: landscape ? landscapeTop : portraitTop

    property Component contents

    anchors {
        topMargin: myTopMargin
    }

    width: 864
    height: 864
    //border.color: 'red'
    //border.width: 1

    transform: Rotation {
        id: poRotator
        origin.x: phoneObject.width * 0.5
        origin.y: phoneObject.height * 0.5
        axis.z: 1
        axis.y: 0
        axis.x: 0
        angle: 0
    }

    SequentialAnimation {
        id: pToL
        ParallelAnimation {
            PropertyAnimation { target: phoneObject; property: 'myTopMargin'; duration: 500; to: phoneObject.landscapeTop }
            RotationAnimation { target: poRotator; property: 'angle'; duration: 500; easing.type: Easing.InOutCubic; to: 90 }
        }
        PropertyAction { target: phoneObject; property: 'landscape'; value: true }
        PropertyAction { target: poRotator; property: 'angle'; value: 0 }
        PropertyAction { target: phoneObject; property: 'rotating'; value: false }
        PropertyAction { target: phoneObject; property: 'width'; value: 864 }
    }
    SequentialAnimation {
        id: lToP
        ParallelAnimation {
            PropertyAnimation { target: phoneObject; property: 'myTopMargin'; duration: 500; to: phoneObject.portraitTop }
            RotationAnimation { target: poRotator; property: 'angle'; duration: 500; easing.type: Easing.InOutCubic; to: -90 }
        }
        PropertyAction { target: phoneObject; property: 'landscape'; value: false }
        PropertyAction { target: poRotator; property: 'angle'; value: 0 }
        PropertyAction { target: phoneObject; property: 'rotating'; value: false }
        PropertyAction { target: phoneObject; property: 'height'; value: 864 }
    }

    function rotate()
    {
        if( rotating )
            return;

        rotating = true;
        if( landscape )
            lToP.start();
        else
            pToL.start();
    }

    Rectangle {
        id: topBar
        color: 'black'

        height: phoneObject.menuHeight
        width: phoneObject.screenSizeX
        anchors {
            left: phoneFrame.left
            leftMargin: phoneObject.insetX
            top: phoneFrame.top
            topMargin: phoneObject.insetY - phoneObject.menuHeight
        }

        Text {
            height: topBar.height
            x: topBar.width * 0.033
            topPadding: topBar.height * 0.3
            verticalAlignment: Text.AlignVCenter
            color: 'white'
            font.pixelSize: topBar.height * 0.33
            font.family: 'sans-serif'
            text: 'DFO Mobile'
        }

        Row {
            height: topBar.height * 0.5
            y: topBar.height * 0.5
            x: topBar.width - (topBar.width * 0.04) - implicitWidth
            spacing: 5
            Antenna {
                height: parent.height * 0.85
                width: height * 1.05
            }

            Wifi {
                height: parent.height * 0.85
                width: height * 1.05
            }
        }
    }

    Rectangle {
        id: bottomBar
        color: 'black'

        height: phoneObject.controlsHeight
        width: phoneObject.screenSizeX
        anchors {
            left: phoneFrame.left
            leftMargin: phoneObject.insetX
            top: phoneFrame.top
            topMargin: phoneObject.insetY + phoneObject.screenSizeY - 1
        }

        Row {
            width: parent.width
            height: parent.height

            MouseArea {
                width: parent.width * 0.33
                height: bottomBar.height
                Image {
                    anchors.centerIn: parent
                    width: height
                    height: parent.height * 0.5
                    source: 'back.svg'
                }
                onClicked: console.log("Back.");
            }
            MouseArea {
                width: parent.width * 0.33
                height: bottomBar.height
                Image {
                    anchors.centerIn: parent
                    width: height
                    height: parent.height * 0.5
                    source: 'home.svg'
                }
                onClicked: console.log("Home.");
            }
            MouseArea {
                width: parent.width * 0.33
                height: bottomBar.height
                Image {
                    anchors.centerIn: parent
                    width: height
                    height: parent.height * 0.5
                    source: phoneObject.landscape ? 'toportrait.svg' : 'tolandscape.svg'
                }
                onClicked: phoneObject.rotate();
            }
        }
    }

    Loader {
        id: game
        sourceComponent: contents

        width: phoneObject.screenSizeX
        height: phoneObject.screenSizeY
        anchors {
            leftMargin: phoneObject.insetX
            topMargin: phoneObject.insetY
            top: phoneFrame.top
            left: phoneFrame.left
        }
    }

    Image {
        id: phoneFrame
        source: 'android.png'
        anchors.centerIn: parent
        transform: Rotation {
            origin.x: phoneFrame.width * 0.5
            origin.y: phoneFrame.height * 0.5
            axis.z: 1
            axis.y: 0
            axis.x: 0
            angle: phoneObject.landscape ? 90 : 0
        }

        width: 465
        height: 864
        //fillMode: Image.PreserveAspectFit
    }
} // phoneObject
