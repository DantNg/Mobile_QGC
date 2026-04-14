import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls

// We implement our own TabButton to get around the fact that QtQuick.Controls TabBar does not
// support hiding tabs. This version supports hiding tabs by setting the visible property
// on the QGCTabButton instances.
Button {
    id: control
    Layout.fillWidth: true
    topPadding: _verticalPadding
    bottomPadding: _verticalPadding
    leftPadding: _horizontalPadding
    rightPadding: _horizontalPadding
    focusPolicy: Qt.ClickFocus
    checkable: true

    property bool primary: false
    property real pointSize: ScreenTools.defaultFontPointSize
    property bool showBorder: false
    property real backRadius: DJIStyle.radiusSM
    property real heightFactor: 0.5

    property bool _showSeparator: false
    property bool _showHighlight: enabled && (pressed | checked)
    property int _horizontalPadding: ScreenTools.defaultFontPixelWidth
    property int _verticalPadding: Math.round(ScreenTools.defaultFontPixelHeight * heightFactor)
    property bool _showIcon: control.icon.source != ""

    QGCPalette { id: qgcPal; colorGroupEnabled: enabled }

    background: Rectangle {
        id: backRect
        implicitWidth: ScreenTools.implicitButtonWidth
        implicitHeight: ScreenTools.implicitButtonHeight
        border.width: showBorder ? 1 : 0
        border.color: qgcPal.buttonBorder
        color: _showHighlight ? DJIStyle.accentColor : qgcPal.button

        // Active tab bottom accent line
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            height: 2
            color: DJIStyle.accentColor
            visible: _showHighlight
        }

        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: _vertMargin
            anchors.bottomMargin: _vertMargin
            width: 1
            color: DJIStyle.dividerColor
            visible: control._showSeparator

            property real _vertMargin: ScreenTools.defaultFontPixelHeight * 0.25
        }

        Behavior on color {
            ColorAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
        }
    }

    contentItem: Item {
        implicitWidth: _showIcon ? icon.width : text.implicitWidth
        implicitHeight: _showIcon ? icon.height : text.implicitHeight
        baselineOffset: text.y + text.baselineOffset

        QGCColoredImage {
            id: icon
            anchors.centerIn: parent
            source: control.icon.source
            height: source === "" ? 0 : ScreenTools.defaultFontPixelHeight
            width: height
            color: _showHighlight ? qgcPal.buttonHighlightText : qgcPal.buttonText
            fillMode: Image.PreserveAspectFit
            sourceSize.height: height
            visible: _showIcon
        }

        Text {
            id: text
            anchors.centerIn: parent
            antialiasing: true
            text: control.text
            font.pointSize: control.pointSize
            font.family: ScreenTools.normalFontFamily
            color: _showHighlight ? qgcPal.buttonHighlightText : qgcPal.buttonText
            visible: !_showIcon
        }
    }
}
