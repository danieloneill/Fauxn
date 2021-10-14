import QtQuick 2.15

Window {
    width: 900
    height: 900
    title: 'Fauxn'

    Fauxn {
        id: fauxn
        anchors.centerIn: parent
        contents: Item {
            Image {
                source: fauxn.landscape ? 'example_landscape.png' : 'example_portrait.png'
                fillMode: Image.Pad
                anchors.centerIn: parent
                width: sourceSize.width
                height: sourceSize.height
            }
        }
    }
}
