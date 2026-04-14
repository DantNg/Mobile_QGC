import QtQuick
import QtQuick.Controls

import QGroundControl
import QGroundControl.Controls

CheckBox {
    id:             control
    spacing:        _noText ? 0 : ScreenTools.defaultFontPixelWidth
    focusPolicy:    Qt.ClickFocus
    leftPadding:    0

    Component.onCompleted: {
        if (_noText) {
            rightPadding = 0
        }
    }

    property color  textColor:          qgcPal.buttonText
    property bool   textBold:           false
    property real   textFontPointSize:  ScreenTools.defaultFontPointSize
    property ButtonGroup buttonGroup: null

    property bool _noText: text === ""

    QGCPalette { id: qgcPal; colorGroupEnabled: control.enabled }

    onButtonGroupChanged: {
        if (buttonGroup) {
            buttonGroup.addButton(control)
        }
    }

    contentItem: Text {
        leftPadding:        control.indicator.width + control.spacing
        verticalAlignment:  Text.AlignVCenter
        text:               control.text
        font.pointSize:     textFontPointSize
        font.bold:          control.textBold
        font.family:        ScreenTools.normalFontFamily
        color:              control.textColor
    }

    indicator: Rectangle {
        implicitWidth:  ScreenTools.implicitCheckBoxHeight
        implicitHeight: implicitWidth
        x:              control.leftPadding
        y:              parent.height / 2 - height / 2
        color:          control.checked ? DJIStyle.accentColor : (control.enabled ? DJIStyle.inputBackground : "transparent")
        border.color:   control.checked ? DJIStyle.accentColor : qgcPal.buttonBorder
        border.width:   1
        radius:         DJIStyle.radiusSM

        // Hover effect
        Rectangle {
            anchors.fill:   parent
            color:          DJIStyle.accentColor
            opacity:        control.hovered && !control.checked ? 0.1 : 0
            radius:         parent.radius

            Behavior on opacity {
                NumberAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
            }
        }

        QGCColoredImage {
            source:             "/qmlimages/checkbox-check.svg"
            color:              DJIStyle.textOnAccent
            mipmap:             true
            fillMode:           Image.PreserveAspectFit
            width:              parent.implicitWidth * 0.7
            height:             width
            sourceSize.height:  height
            visible:            control.checked
            anchors.centerIn:   parent

            // Fade-in animation for check mark
            opacity:            control.checked ? 1.0 : 0.0
            Behavior on opacity {
                NumberAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
            }
        }

        Behavior on color {
            ColorAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
        }

        Behavior on border.color {
            ColorAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
        }
    }
}
