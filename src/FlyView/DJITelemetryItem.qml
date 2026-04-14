import QtQuick
import QtQuick.Layouts

import QGroundControl.Controls

/// Single telemetry value item for the DJI-style bottom bar
/// Shows: icon (optional) + label + large value + unit
Item {
    id: control
    implicitWidth:  itemLayout.implicitWidth
    implicitHeight: itemLayout.implicitHeight

    property string icon:    ""
    property string label:   ""
    property string value:   "0"
    property string unit:    ""
    property bool   isUp:    true
    property bool   isBold:  false

    RowLayout {
        id:         itemLayout
        spacing:    DJIStyle.spacingXS

        // Direction arrow icon (optional)
        QGCColoredImage {
            visible:            control.icon !== ""
            source:             control.icon
            width:              ScreenTools.defaultFontPixelHeight * 0.8
            height:             width
            sourceSize.width:   width
            color:              DJIStyle.textSecondary
            fillMode:           Image.PreserveAspectFit
            rotation:           control.isUp ? 0 : 180
            Layout.alignment:   Qt.AlignVCenter
        }

        // Label (V.S, H.S, H, D)
        Text {
            text:               control.label + ":"
            color:              DJIStyle.textSecondary
            font.pixelSize:     ScreenTools.defaultFontPixelHeight * 0.75
            font.family:        ScreenTools.normalFontFamily
            Layout.alignment:   Qt.AlignBaseline
        }

        // Value (large number)
        Text {
            text:               control.value
            color:              DJIStyle.textPrimary
            font.pixelSize:     ScreenTools.defaultFontPixelHeight * (control.isBold ? 1.3 : 1.15)
            font.family:        ScreenTools.demiBoldFontFamily
            font.bold:          true
            Layout.alignment:   Qt.AlignBaseline
        }

        // Unit label
        Text {
            text:               control.unit
            color:              DJIStyle.textSecondary
            font.pixelSize:     ScreenTools.defaultFontPixelHeight * 0.6
            font.family:        ScreenTools.normalFontFamily
            Layout.alignment:   Qt.AlignBaseline
        }
    }
}
