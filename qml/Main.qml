import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    id: root

    width: 600
    height: 600
    visible: true

    property int screenCount: 0

    signal append(int x, url source, int screen);

    function addScreen() {
        screenCount++
        var component = Qt.createComponent("Screen.qml")
        var window    = component.createObject(root, {
            "title": "Waterfall Screen " + root.screenCount,
            "objectName": root.screenCount
        })
        window.show()
    }

    Button {
        anchors.centerIn: parent
        width: 140
        height: 140
        text: qsTr("Add screen")
        onClicked: {
            root.addScreen()
        }
    }
}
