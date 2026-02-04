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
            
            Repeater {
                model: 3
            Text {
                anchors.centerIn: parent
                property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
                property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
                text: index + 1
                color: isActive ? "#0db9d7" : (ws ? "#7aa2f7" : "#444b6a")
                font { pixelSize: 14; bold: true }
                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("workspace " + (index + 1))
                }
            }

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