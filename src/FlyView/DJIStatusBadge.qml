import QtQuick
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls

/// DJI-style "Safe to fly (GPS)" status badge for the toolbar center area
/// Shows flight readiness status with colored background
Rectangle {
    id: control
    implicitWidth:  statusRow.implicitWidth + DJIStyle.spacingLG * 2
    implicitHeight: statusRow.implicitHeight + DJIStyle.spacingSM * 2
    radius:         DJIStyle.radiusSM
    color:          _statusColor

    property var  _activeVehicle: QGroundControl.multiVehicleManager.activeVehicle
    property bool _armed:         _activeVehicle ? _activeVehicle.armed : false
    property bool _flying:        _activeVehicle ? _activeVehicle.flying : false
    property bool _landing:       _activeVehicle ? _activeVehicle.landing : false
    property bool _communicationLost: _activeVehicle ? _activeVehicle.vehicleLinkManager.communicationLost : false
    property bool _healthAndArmingChecksSupported: _activeVehicle ? _activeVehicle.healthAndArmingCheckReport.supported : false
    property int  _gpsCount:      _activeVehicle ? _activeVehicle.gps.count.rawValue : 0

    property color _statusColor:  DJIStyle.statusGreen
    property string _statusText:  qsTr("Safe to fly")
    property string _gpsText:     _gpsCount > 0 ? qsTr("(GPS)") : qsTr("(No GPS)")

    // Update status based on vehicle state
    function updateStatus() {
        if (!_activeVehicle) {
            _statusColor = DJIStyle.textTertiary
            _statusText  = qsTr("Disconnected")
            return
        }

        if (_communicationLost) {
            _statusColor = DJIStyle.statusRed
            _statusText  = qsTr("Signal Lost")
            return
        }

        if (_armed) {
            if (_flying) {
                _statusColor = DJIStyle.statusGreen
                _statusText  = qsTr("Flying")
            } else if (_landing) {
                _statusColor = DJIStyle.statusOrange
                _statusText  = qsTr("Landing")
            } else {
                _statusColor = DJIStyle.statusGreen
                _statusText  = qsTr("Armed")
            }
            return
        }

        // Not armed - check readiness
        if (_healthAndArmingChecksSupported) {
            if (_activeVehicle.healthAndArmingCheckReport.canArm) {
                if (_activeVehicle.healthAndArmingCheckReport.hasWarningsOrErrors) {
                    _statusColor = DJIStyle.statusYellow
                    _statusText  = qsTr("Safe to fly")
                } else {
                    _statusColor = DJIStyle.statusGreen
                    _statusText  = qsTr("Safe to fly")
                }
            } else {
                _statusColor = DJIStyle.statusRed
                _statusText  = qsTr("Not Safe")
            }
        } else if (_activeVehicle.readyToFlyAvailable) {
            if (_activeVehicle.readyToFly) {
                _statusColor = DJIStyle.statusGreen
                _statusText  = qsTr("Safe to fly")
            } else {
                _statusColor = DJIStyle.statusYellow
                _statusText  = qsTr("Not Ready")
            }
        } else {
            _statusColor = DJIStyle.statusYellow
            _statusText  = qsTr("Checking...")
        }
    }

    Component.onCompleted: updateStatus()
    on_ActiveVehicleChanged: updateStatus()
    on_ArmedChanged: updateStatus()
    on_FlyingChanged: updateStatus()
    on_LandingChanged: updateStatus()
    on_CommunicationLostChanged: updateStatus()
    on_GpsCountChanged: updateStatus()

    Connections {
        target: _activeVehicle ? _activeVehicle.healthAndArmingCheckReport : null
        function onCanArmChanged() { control.updateStatus() }
        function onHasWarningsOrErrorsChanged() { control.updateStatus() }
    }

    RowLayout {
        id:                 statusRow
        anchors.centerIn:   parent
        spacing:            DJIStyle.spacingXS

        Text {
            text:               _statusText
            color:              DJIStyle.textOnAccent
            font.pixelSize:     ScreenTools.defaultFontPixelHeight * 0.85
            font.family:        ScreenTools.demiBoldFontFamily
            font.bold:          true
        }

        Text {
            text:               _gpsText
            color:              Qt.darker(DJIStyle.textOnAccent, 1.2)
            font.pixelSize:     ScreenTools.defaultFontPixelHeight * 0.75
            font.family:        ScreenTools.normalFontFamily
            visible:            _activeVehicle !== null
        }
    }

    Behavior on color {
        ColorAnimation { duration: DJIStyle.animNormal }
    }
}
