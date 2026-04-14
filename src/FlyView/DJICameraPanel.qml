import QtQuick
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls

/// DJI-style right camera control panel
/// Shows camera shutter, video record, gimbal control, and settings
Item {
    id: control
    width:  DJIStyle.spacingXXL * 3
    height: cameraColumn.height

    property var _activeVehicle:  QGroundControl.multiVehicleManager.activeVehicle
    property var _dynamicCameras: _activeVehicle ? _activeVehicle.cameraManager : null
    property bool _isCamera:     _dynamicCameras ? _dynamicCameras.cameras.count > 0 : false
    property var  _camera:       _isCamera ? _dynamicCameras.cameras.get(_dynamicCameras.currentCamera) : null

    visible: _activeVehicle !== null

    ColumnLayout {
        id:         cameraColumn
        anchors.horizontalCenter: parent.horizontalCenter
        spacing:    DJIStyle.spacingLG

        // AE Lock indicator
        Rectangle {
            Layout.alignment:   Qt.AlignHCenter
            width:              ScreenTools.defaultFontPixelHeight * 2.5
            height:             width
            radius:             DJIStyle.radiusSM
            color:              DJIStyle.overlayBackground
            border.width:       DJIStyle.hudBorderWidth
            border.color:       DJIStyle.hudBorder

            Column {
                anchors.centerIn: parent
                spacing: 1

                Text {
                    text:               "AE"
                    color:              DJIStyle.textPrimary
                    font.pixelSize:     ScreenTools.defaultFontPixelHeight * 0.6
                    font.bold:          true
                    font.family:        ScreenTools.normalFontFamily
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                QGCColoredImage {
                    source:             "qrc:/InstrumentValueIcons/lock-closed.svg"
                    width:              ScreenTools.defaultFontPixelHeight * 0.6
                    height:             width
                    sourceSize.width:   width
                    color:              DJIStyle.textSecondary
                    fillMode:           Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible:            false // Show when AE locked
                }
            }
        }

        // Camera shutter button (photo)
        Rectangle {
            Layout.alignment:   Qt.AlignHCenter
            width:              ScreenTools.defaultFontPixelHeight * 4
            height:             width
            radius:             width / 2
            color:              "transparent"
            border.width:       3
            border.color:       DJIStyle.textPrimary

            Rectangle {
                anchors.centerIn:   parent
                width:              parent.width - DJIStyle.spacingSM * 2
                height:             width
                radius:             width / 2
                color:              DJIStyle.textPrimary

                Behavior on scale {
                    NumberAnimation { duration: DJIStyle.animFast }
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (_camera) {
                        _camera.takePhoto()
                    }
                }
                onPressed: parent.children[0].scale = 0.9
                onReleased: parent.children[0].scale = 1.0
            }
        }

        // Record / Gallery button
        Rectangle {
            Layout.alignment:   Qt.AlignHCenter
            width:              ScreenTools.defaultFontPixelHeight * 2.5
            height:             width
            radius:             DJIStyle.radiusSM
            color:              DJIStyle.overlayBackground
            border.width:       DJIStyle.hudBorderWidth
            border.color:       DJIStyle.hudBorder

            QGCColoredImage {
                anchors.centerIn:   parent
                source:             "/InstrumentValueIcons/play.svg"
                width:              parent.width * 0.5
                height:             width
                sourceSize.width:   width
                color:              DJIStyle.textPrimary
                fillMode:           Image.PreserveAspectFit
            }
        }

        // Gimbal control slider placeholder
        Rectangle {
            Layout.alignment:   Qt.AlignHCenter
            width:              4
            height:             ScreenTools.defaultFontPixelHeight * 6
            radius:             2
            color:              DJIStyle.dividerColor

            Rectangle {
                id:     gimbalHandle
                width:  ScreenTools.defaultFontPixelHeight * 1.2
                height: width
                radius: width / 2
                color:  DJIStyle.textPrimary
                x:      (parent.width - width) / 2
                y:      (parent.height - height) / 2

                MouseArea {
                    anchors.fill: parent
                    drag.target:  gimbalHandle
                    drag.axis:    Drag.YAxis
                    drag.minimumY: 0
                    drag.maximumY: gimbalHandle.parent.height - gimbalHandle.height
                }
            }
        }
    }
}
