import QtQuick
import QtQuick.Controls

import QGroundControl
import QGroundControl.Controls

RadioButton {
    id:             control
    font.family:    ScreenTools.normalFontFamily
    font.pointSize: ScreenTools.defaultFontPointSize

    property color  textColor:  qgcPal.text
    property bool   _noText:    text === ""

    QGCPalette { id:qgcPal; colorGroupEnabled: enabled }

    indicator: Rectangle {
        implicitWidth:          ScreenTools.radioButtonIndicatorSize
        implicitHeight:         width
        color:                  control.checked ? DJIStyle.accentColor : (control.enabled ? DJIStyle.inputBackground : "transparent")
        border.color:           control.checked ? DJIStyle.accentColor : qgcPal.buttonBorder
        border.width:           1
        radius:                 height / 2
        x:                      control.leftPadding
        y:                      parent.height / 2 - height / 2

        Rectangle {
            anchors.fill:   parent
            color:          DJIStyle.accentColor
            opacity:        control.hovered && !control.checked ? 0.1 : 0
            radius:         parent.radius

            Behavior on opacity {
                NumberAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
            }
        }

        Rectangle {
            anchors.centerIn:   parent
            width:              2 * Math.floor(parent.width / 4) + 1
            height:             width
            antialiasing:       true
            radius:             height * 0.5
            color:              DJIStyle.textOnAccent
            visible:            control.checked
        }

        Behavior on color {
            ColorAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
        }

        Behavior on border.color {
            ColorAnimation { duration: DJIStyle.animFast; easing.type: DJIStyle.animEasing }
        }
    }

    contentItem: Text {
        text:               control.text
        font.family:        control.font.pointSize
        font.pointSize:     control.font.pointSize
        font.bold:          control.font.bold
        color:              control.textColor
        verticalAlignment:  Text.AlignVCenter
        leftPadding:        control.indicator.width + (_noText ? 0 : ScreenTools.defaultFontPixelWidth * 0.25)
    }

}
