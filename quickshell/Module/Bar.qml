import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts

PanelWindow {
    id: bar
    
    color: "black"
    anchors {
        left: true
        top: true
        right: true
    }

    implicitHeight: 30

    SystemClock {
    id: clock
    precision: SystemClock.Seconds

    }

    Rectangle {
        Text {
            text: Qt.formatDateTime(clock.date, "hh:mm:ss - yyyy-MM-dd")
            color: "white"

        }

        x: 900
    }
}