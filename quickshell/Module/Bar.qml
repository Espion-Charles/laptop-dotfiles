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
            
            Rectangle {
                implicitHeight: 30
                implicitWidth: 120
                color: "black"
                radius: 10
                anchors.left: parent.left
                anchors.leftMargin: 200
                Text {
                    text: "workspaces soon"
                    color: "white"
                }
            }

            Rectangle {
                implicitHeight: 30
                implicitWidth: 120
                color: "black"
                radius: 10
                anchors.centerIn: parent
                    ClockWidget {
                    anchors.centerIn: parent
                    color: "white"
                }
            }
            Rectangle {
                implicitHeight: 30
                implicitWidth: 120
                color: "black"
                radius: 10
                anchors.right: parent.right
                Text {
                    text: "Wifi and stuff"
                    color: "white"
                }
            }
        }
    }
}