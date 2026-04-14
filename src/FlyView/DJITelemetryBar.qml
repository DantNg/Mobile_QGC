import QtQuick
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls

/// DJI-style bottom telemetry bar showing V.S, H.S, H, D
/// Positioned at bottom-center of the FlyView, matching DJI Fly app layout
Item {
    id: control
    implicitWidth:  telemetryRow.width + DJIStyle.spacingXL * 2
    implicitHeight: telemetryRow.height + DJIStyle.spacingSM * 2

    property var _activeVehicle: QGroundControl.multiVehicleManager.activeVehicle

    // Telemetry values from vehicle
    property real _verticalSpeed:   _activeVehicle ? _activeVehicle.climbRate.rawValue   : 0
    property real _horizontalSpeed: _activeVehicle ? _activeVehicle.groundSpeed.rawValue : 0
    property real _altitude:        _activeVehicle ? _activeVehicle.altitudeRelative.rawValue : 0
    property real _distance:        _activeVehicle ? _activeVehicle.distanceToHome.rawValue   : 0

    // Units
    property string _speedUnits:    _activeVehicle ? _activeVehicle.climbRate.units      : "m/s"
    property string _altUnits:      _activeVehicle ? _activeVehicle.altitudeRelative.units : "m"
    property string _distUnits:     _activeVehicle ? _activeVehicle.distanceToHome.units   : "m"

    // Background
    Rectangle {
        anchors.fill: parent
        color:        DJIStyle.hudBackground
        radius:       DJIStyle.cardRadius
        border.width: DJIStyle.hudBorderWidth
        border.color: DJIStyle.hudBorder
    }

    RowLayout {
        id:                     telemetryRow
        anchors.centerIn:       parent
        spacing:                DJIStyle.spacingXL

        // Vertical Speed
        DJITelemetryItem {
            icon:   "qrc:/InstrumentValueIcons/arrow-thick-up.svg"
            label:  "V.S"
            value:  Math.abs(_verticalSpeed).toFixed(1)
            unit:   _speedUnits
            isUp:   _verticalSpeed >= 0
        }

        // Separator
        Rectangle { width: 1; height: 28; color: DJIStyle.dividerColor; Layout.alignment: Qt.AlignVCenter }

        // Horizontal Speed
        DJITelemetryItem {
            icon:   "qrc:/InstrumentValueIcons/arrow-thick-right.svg"
            label:  "H.S"
            value:  _horizontalSpeed.toFixed(1)
            unit:   _speedUnits
        }

        // Separator
        Rectangle { width: 1; height: 28; color: DJIStyle.dividerColor; Layout.alignment: Qt.AlignVCenter }

        // Height (Altitude)
        DJITelemetryItem {
            label:  "H"
            value:  _altitude.toFixed(0)
            unit:   _altUnits
            isBold: true
        }

        // Separator
        Rectangle { width: 1; height: 28; color: DJIStyle.dividerColor; Layout.alignment: Qt.AlignVCenter }

        // Distance from home
        DJITelemetryItem {
            label:  "D"
            value:  _distance.toFixed(0)
            unit:   _distUnits
            isBold: true
        }
    }
}
