import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.SystemTray
import Quickshell.Io

ShellRoot {
    property var workspaceList: []
    property string currentWindowTitle: ""
    property string currentWindowApp: ""
    property string currentTime: ""

    // --- LOGIK DATA WORKSPACE ---
    Process {
        id: niriWorkspaces
        command: ["sh", "-c", "niri msg -j workspaces"]
        running: true
        
        stdout: StdioCollector {
            onStreamFinished: {
                var rawText = this.text.trim();
                if (rawText !== "") {
                    try {
                        var parsed = JSON.parse(rawText);
                        if (Array.isArray(parsed)) {
                            parsed.sort((a, b) => a.idx - b.idx);
                            workspaceList = parsed;
                        }
                    } catch(e) {}
                }
            }
        }
    }

    // --- LOGIK DATA WINDOW TITLE & APP CLASS ---
    Process {
        id: niriFocusedWindow
        command: ["sh", "-c", "niri msg -j focused-window"]
        running: true
        
        stdout: StdioCollector {
            onStreamFinished: {
                var rawText = this.text.trim();
                if (rawText !== "") {
                    try {
                        var parsed = JSON.parse(rawText);
                        if (parsed) {
                            currentWindowTitle = parsed.title ?? "";
                            currentWindowApp = parsed.app_id ?? parsed.class ?? "";
                        } else {
                            currentWindowTitle = "";
                            currentWindowApp = "";
                        }
                    } catch(e) {
                        currentWindowTitle = "";
                        currentWindowApp = "";
                    }
                } else {
                    currentWindowTitle = "";
                    currentWindowApp = "";
                }
            }
        }
    }

    // --- LOGIK DATA JAM ---
    Timer {
        id: clockTimer
        interval: 1000 // Diperbarui setiap 1 detik
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            var date = new Date();
            // Format waktu menjadi Jam:Menit:Detik (HH:MM:SS) 24-jam
            currentTime = date.toLocaleTimeString(Qt.locale("id_ID"), "HH:mm:ss");
        }
    }

    // Timer Sinkronisasi Niri IPC
    Timer {
        id: refreshTimer
        interval: 200 
        running: true
        repeat: true
        onTriggered: {
            niriWorkspaces.running = true;
            niriFocusedWindow.running = true;
        }
    }

    // --- FUNGSI PEMETAAN IKON ---
    function getWindowIcon(appString) {
        var app = appString.toLowerCase();
        if (app.includes("firefox")) return " ";
        if (app.includes("chrome") || app.includes("chromium")) return " ";
        if (app.includes("terminal") || app.includes("alacritty") || app.includes("kitty") || app.includes("ghostty")) return " ";
        if (app.includes("code") || app.includes("vscode")) return "   ";
        if (app.includes("neovim") || app.includes("nvim")) return " ";
        if (app.includes("emacs")) return " ";
        if (app.includes("thunar") || app.includes("yazi") || app.includes("nemo")) return "   ";
        if (app === "") return "";
        return "   ";
    }

    // --- VISUAL WINDOW BAR ---
    PanelWindow {
        anchors.top: true
        anchors.left: true
        anchors.right: true
        implicitHeight: 14 // Tetap terkunci mutlak di 14px
        
        color: "#000000" 

        RowLayout {
            anchors.fill: parent
            spacing: 0

            // ================= KIRI: WORKSPACES & WINDOW TITLE =================
            Row {
                Layout.alignment: Qt.AlignLeft
                spacing: 16 
                anchors.verticalCenter: parent.verticalCenter
                
                Row {
                    spacing: 4 
                    anchors.verticalCenter: parent.verticalCenter
                    
                    Repeater {
                        model: workspaceList
                        
                        Rectangle {
                            width: 16
                            height: 14 
                            radius: 2 
                            color: modelData.is_focused ? "#f38ba8" : ((modelData.active_window_id !== null && modelData.active_window_id !== undefined) ? "#585b70" : "transparent")

                            Text {
                                anchors.centerIn: parent
                                text: (modelData.name && modelData.name !== "") ? modelData.name : (modelData.idx !== undefined ? modelData.idx.toString() : "")
                                color: modelData.is_focused ? "#000000" : ((modelData.active_window_id !== null && modelData.active_window_id !== undefined) ? "#11111b" : "#45475a")
                                font.bold: modelData.is_focused
                                font.pixelSize: 10
                                font.family: "JetBrainsMono Nerd Font"
                                verticalAlignment: Text.AlignVCenter
                            }
                        }
                    }
                }

                Row {
                    spacing: 5
                    visible: currentWindowTitle !== ""
                    anchors.verticalCenter: parent.verticalCenter

                    Text {
                        text: getWindowIcon(currentWindowApp)
                        color: "#89b4fa" 
                        font.pixelSize: 10 
                        font.family: "JetBrainsMono Nerd Font"
                        verticalAlignment: Text.AlignVCenter
                    }

                    Text {
                        text: currentWindowTitle
                        color: "#89b4fa" 
                        font.pixelSize: 10 
                        font.family: "JetBrainsMono Nerd Font"
                        font.bold: false
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight 
                        Layout.maximumWidth: 500 
                    }
                }
            }

            // Spacer tengah
            Item {
                Layout.fillWidth: true
            }

            // ================= KANAN: JAM & SYSTEM TRAY =================
            Row {
                Layout.alignment: Qt.AlignRight
                spacing: 12 // Jarak renggang antara teks jam dan barisan Systray
                anchors.verticalCenter: parent.verticalCenter
                
                Layout.preferredHeight: 14

                // Teks Jam Minimalis
                Text {
                    text: currentTime
                    color: "#89b4fa" // Senada dengan warna Window Title & Active Workspace
                    font.pixelSize: 10 // Ukuran mikro 10px agar pas secara vertikal
                    font.family: "JetBrainsMono Nerd Font"
                    font.bold: false
                    anchors.verticalCenter: parent.verticalCenter
                    verticalAlignment: Text.AlignVCenter
                }

                // Barisan System Tray
                Row {
                    spacing: 6
                    anchors.verticalCenter: parent.verticalCenter
                    
                    Repeater {
                        model: SystemTray.items
                        
                        Item {
                            width: 16 
                            height: 16
                            anchors.verticalCenter: parent.verticalCenter
                            clip: false 
                            
                            Image {
                                anchors.fill: parent
                                source: modelData.icon ?? ""
                                fillMode: Image.PreserveAspectFit
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                onClicked: (mouse) => {
                                    if (mouse.button === Qt.RightButton) {
                                        modelData.contextMenu()
                                    } else {
                                        modelData.activate()
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
