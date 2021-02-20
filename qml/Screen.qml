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
            objectName: objectName,
            side: objectSide
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
            const x = Math.random() * (parent.width - objectSide)
            const url = "https://source.unsplash.com/random"
            appendToNextScreen(x, url, 1)
        }
    }

    function appendToNextScreen(x, url, scr) {

        if ((objectName == scr) && (parseInt(scr) == parseInt(screenCount))){
            createNewObj(x, url, false)
            return;
        }

        if((objectName == scr) && (parseInt(scr) < parseInt(screenCount))) {
            createNewObj(x, url, true)
            return;
        }
    }

    Component.onCompleted: {
        if (objectName == 1) {
            timer.running = true;
        } else {
            append.connect(appendToNextScreen);
        }
    }
}

