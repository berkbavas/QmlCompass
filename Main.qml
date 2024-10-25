import QtQuick 2.0

Window {
    width: 900
    height: 900
    minimumHeight: 320
    minimumWidth: 320
    visible: true
    title: "QML Compass"

    FontLoader {
        source: "qrc:/Resources/Fonts/Noto_Serif/NotoSerif-Regular.ttf"
    }

    property double scaling: Math.min(width / 1024, height / 1024)

    CompassModern {
        anchors.centerIn: parent
        scale: 0.9 * scaling

        NumberAnimation on heading {
            loops: Animation.Infinite
            from: 0
            to: 360
            running: true
            duration: 15000
        }
    }

}
