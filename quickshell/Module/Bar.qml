import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import QtQuick.Layouts
import "./Widgets"

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            
            anchors {
                top: true
                left: true
                right: true
            }
            implicitHeight: 30
            color: "transparent"
            
            ClockWidget {
                anchors.centerIn: parent
                color: "white"
            }
            
        }
    }
}