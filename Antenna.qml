import QtQuick 2.15

Item {
    id: antenna
    width: 300
    height: 300

    property color activeColour: 'white'
    property color inactiveColour: '#323232'
    property int signalLevel: 3

    Timer {
        interval: 4000
        onTriggered: {
            var nlev = antenna.signalLevel;
            var r = Math.random(1);
            if( r > 0.6 && r < 0.8 )
                nlev--;
            else if( r >= 0.8 )
                nlev++;

            if( nlev < 1 )
                nlev = 1;
            else if( nlev > 5 )
                nlev = 5;
            antenna.signalLevel = nlev;
        }
        repeat: Animation.Infinite
        running: true
    }

    Rectangle {
        id: bar1
        color: antenna.signalLevel >= 1 ? antenna.activeColour : antenna.inactiveColour
        width: parent.width * 0.15
        height: parent.height * 0.1

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: parent.width * 0.05
    }

    Rectangle {
        id: bar2
        color: antenna.signalLevel >= 2 ? antenna.activeColour : antenna.inactiveColour
        width: parent.width * 0.15
        height: parent.height * 0.3

        anchors.bottom: parent.bottom
        anchors.left: bar1.right
        anchors.leftMargin: parent.width * 0.05
    }

    Rectangle {
        id: bar3
        color: antenna.signalLevel >= 3 ? antenna.activeColour : antenna.inactiveColour
        width: parent.width * 0.15
        height: parent.height * 0.5

        anchors.bottom: parent.bottom
        anchors.left: bar2.right
        anchors.leftMargin: parent.width * 0.05
    }

    Rectangle {
        id: bar4
        color: antenna.signalLevel >= 4 ? antenna.activeColour : antenna.inactiveColour
        width: parent.width * 0.15
        height: parent.height * 0.7

        anchors.bottom: parent.bottom
        anchors.left: bar3.right
        anchors.leftMargin: parent.width * 0.05
    }

    Rectangle {
        id: bar5
        color: antenna.signalLevel >= 5 ? antenna.activeColour : antenna.inactiveColour
        width: parent.width * 0.15
        height: parent.height * 0.9

        anchors.bottom: parent.bottom
        anchors.left: bar4.right
        anchors.leftMargin: parent.width * 0.05
    }
}
