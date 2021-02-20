import QtQuick 2.3

Item {
    id: animatedItem
    property string url: ""
    property int side: 0
    property int duration: 2000
    property int posY: 0 - side
    property int currentScreen
    
    property int currentPosY: 0
    property double currentDuration: 0
    property double travelTimeOfPixel: duration / (parent.height + side)
    property bool passingFlag: false

    signal endOfScreen(int x, url source, int screen);

    width: side 
    height: side
    

    Image {
        anchors.fill: parent
        source: url
    }

    MouseArea {
        id: dragArea
        anchors.fill: parent
        drag.target: parent
        onPressed: animatedItem.state = "pressed"
        onReleased: animatedItem.state = "released"
    }
    
    SequentialAnimation {
        id: animation
        NumberAnimation { 
            target: animatedItem
            property: "y"
            from: currentPosY
            to: parent.height
            duration: currentDuration
        }
        onRunningChanged: {
            if (!running && animatedItem.y == parent.height) {
                animatedItem.destroy();
            }
        }
    }
     
    onYChanged: {
        if(animatedItem.y >= (parent.height - side) && !passingFlag) {
            animatedItem.endOfScreen(animatedItem.x, animatedItem.url, parseInt(objectName) + 1)
            passingFlag = true
        }
    }

    onPosYChanged: {
        currentDuration = duration
        currentPosY = posY
        animation.start()
    }

    states: [
        State {
            name: "pressed";
            PropertyChanges { 
                target: animatedItem;
                currentPosY: animatedItem.y;
            }
            StateChangeScript {
                name: "stopAnimation"
                script: {
                    animation.stop()
                }
            }
        },
        State {
            name: "released";
            StateChangeScript {
                name: "continueAnimation"
                script: {
                    currentDuration = (parent.height - animatedItem.y) * travelTimeOfPixel
                    animation.restart()
                }
            }
        }
    ]
}
