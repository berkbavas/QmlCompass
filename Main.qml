import QtQuick 2.0

Window {
    width: 800
    height: 800
    visible: true
    title: "QML Compass"

    FontLoader {
        source: "qrc:/Resources/Fonts/Noto_Serif/NotoSerif-Regular.ttf"
    }

    property double scaling: Math.min(width / 800, height / 800)

    Compass {
        anchors.centerIn: parent
        scale: scaling

        NumberAnimation on heading {
            loops: Animation.Infinite
            from: 0
            to: 360
            running: true
            duration: 15000
        }
    }
}
