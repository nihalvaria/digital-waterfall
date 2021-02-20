import QtQuick 2.3
import QtQuick.Controls 1.2

ApplicationWindow {
    width: 400
    height: 400
    visible: true

    Item {
        anchors.fill: parent
        focus: true

        property bool isFullScreen: false

        function toggleScreen() {
            if (this.state == "max")
                this.state = "min";
            else
                this.state = "max";
        }

        Keys.onEscapePressed: {
            toggleScreen()
        }
        
        states: [
            State {
                name: "max"
                PropertyChanges { 
                    target: screen
                    isFullScreen: true 
                }
                StateChangeScript {
                    script: screen.showFullScreen()
                }
            },
            State {
                name: "min"
                PropertyChanges { 
                    target: screen
                    isFullScreen: false 
                }
                StateChangeScript {
                    script: screen.showNormal()
                }
            }
        ]
    }
}
