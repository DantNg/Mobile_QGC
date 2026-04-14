import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import QGroundControl
import QGroundControl.Controls

/// Modern flat button with DJI-inspired styling:
///     Rounded corners, subtle hover/press animations, clean typography.
///     If there is both an icon and text the icon will be to the left of the text
///     If icon only, icon will be centered
Button {
    property bool primary: false
    property bool showBorder: false
    property real backRadius: DJIStyle.buttonRadius
    property real heightFactor: 0.5
    property string iconSource: ""
    property real fontWeight: Font.Normal
    property real pointSize: ScreenTools.defaultFontPointSize

    property alias wrapMode: text.wrapMode
    property alias horizontalAlignment: text.horizontalAlignment
    property alias backgroundColor: backRect.color
    property alias textColor: text.color

    id: control
    hoverEnabled: !ScreenTools.isMobile
    topPadding: _verticalPadding
    bottomPadding: _verticalPadding
    leftPadding: _horizontalPadding
    rightPadding: _horizontalPadding
    focusPolicy: Qt.ClickFocus
    font.family: ScreenTools.normalFontFamily
    text: ""

    property bool _showHighlight: enabled && (pressed | checked)
    property int _horizontalPadding: ScreenTools.defaultFontPixelWidth * 2
    property int _verticalPadding: Math.round(ScreenTools.defaultFontPixelHeight * heightFactor) - (iconSource === "" ? 0 : (_iconHeight - ScreenTools.defaultFontPixelHeight)  / 2)
    property real _iconHeight: text.height * 1.5

    QGCPalette { id: qgcPal; colorGroupEnabled: control.enabled }

    background: Rectangle {
        id: backRect
        radius: backRadius
        implicitWidth: ScreenTools.implicitButtonWidth
        implicitHeight: ScreenTools.implicitButtonHeight
        border.width: showBorder ? 1 : 0
        border.color: qgcPal.buttonBorder
        color: primary ? qgcPal.primaryButton : qgcPal.button

        // Modern hover/press overlay with animation
        Rectangle {
            anchors.fill: parent
            color: _showHighlight ? qgcPal.buttonHighlight : (control.enabled && control.hovered ? qgcPal.buttonHighlight : "transparent")
            opacity: _showHighlight ? 1 : control.enabled && control.hovered ? 0.15 : 0
            radius: parent.radius

            Behavior on opacity {
                NumberAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
            }
        }

        // Subtle bottom accent line for primary buttons
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.6
            height: 2
            radius: 1
            color: DJIStyle.accentColor
            visible: primary && control.enabled
            opacity: _showHighlight ? 1.0 : 0.0

            Behavior on opacity {
                NumberAnimation { duration: DJIStyle.animNormal; easing.type: DJIStyle.animEasing }
            }
        }

        Behavior on color {
            ColorAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
        }
    }

    contentItem: RowLayout {
        spacing: ScreenTools.defaultFontPixelWidth

        QGCColoredImage {
            id: icon
            Layout.alignment: Qt.AlignHCenter
            source: control.iconSource
            height: _iconHeight
            width: height
            color: text.color
            fillMode: Image.PreserveAspectFit
            sourceSize.height: height
            visible: control.iconSource !== ""
        }

        QGCLabel {
            id: text
            Layout.alignment: Qt.AlignHCenter
            text: control.text
            font.pointSize: control.pointSize
            font.family: control.font.family
            font.weight: fontWeight
            color: _showHighlight ? qgcPal.buttonHighlightText : (primary ? qgcPal.primaryButtonText : qgcPal.buttonText)
            visible: control.text !== ""

            Behavior on color {
                ColorAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
            }
        }
    }

    // Subtle scale animation on press
    scale: _showHighlight ? 0.97 : 1.0
    Behavior on scale {
        NumberAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasingBounce }
    }
}
