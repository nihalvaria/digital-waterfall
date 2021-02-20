import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    width: 600
    height: 600
    id: screen
    
    property int objectSide: 200

    Rectangle {
        anchors.fill: parent
        color: "dodgerblue"
    }

    function createNewObj(x, url, connect) {
        var component = Qt.createComponent("Draggable.qml");
        var dynamicObject = component.createObject(screen, {
            x: x,
            url: url,
            side: screen.objectSide
        });
        if (connect) {
            dynamicObject.endOfScreen.connect(append)
        }
    }

    Timer {
        id: timer
        interval: 2000; 
        running: false; 
        repeat: true;
        onTriggered: {
            screen.update()
            const x = Math.random() * (parent.width - objectSide)
            const url = "https://source.unsplash.com/random"
            screen.createNewObj(x, url, true)
        }
    }

    function appendToNextScreen(x, url) {
        screen.createNewObj(x, url, false)
    }

    Component.onCompleted: {
        if (screen.objectName == 1) {
            timer.running = true;
        } else {
            append.connect(appendToNextScreen);
        }
    }
}

