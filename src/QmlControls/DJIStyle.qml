pragma Singleton

import QtQuick

/// Centralized DJI-inspired style constants for the modern UI redesign.
/// This singleton provides colors, spacing, typography, and animation
/// parameters used across all QML components.
///
/// Usage:
///     import QGroundControl.Controls
///     Rectangle {
///         color: DJIStyle.cardBackground
///         radius: DJIStyle.cardRadius
///     }
QtObject {
    id: root

    // ─── Color Palette ────────────────────────────────────────────────
    // Primary backgrounds
    readonly property color backgroundColor:        "#0D0D0D"
    readonly property color surfaceColor:           "#1A1A1A"
    readonly property color cardBackground:         "#1E1E1E"
    readonly property color elevatedSurface:        "#252525"
    readonly property color overlayBackground:      "#CC1A1A1A"  // 80% opacity

    // Accent colors (DJI-inspired cyan/blue)
    readonly property color accentColor:            "#00D4FF"
    readonly property color accentColorHover:       "#33DDFF"
    readonly property color accentColorPressed:     "#009BC2"
    readonly property color accentColorDim:         "#0080A8"

    // Text colors
    readonly property color textPrimary:            "#FFFFFF"
    readonly property color textSecondary:          "#B0B0B0"
    readonly property color textTertiary:           "#707070"
    readonly property color textDisabled:           "#4A4A4A"
    readonly property color textOnAccent:           "#000000"

    // Status colors
    readonly property color statusGreen:            "#00E676"
    readonly property color statusYellow:           "#FFD600"
    readonly property color statusOrange:           "#FF9100"
    readonly property color statusRed:              "#FF1744"
    readonly property color statusBlue:             "#448AFF"

    // Border & divider
    readonly property color borderColor:            "#333333"
    readonly property color borderColorLight:       "#444444"
    readonly property color dividerColor:           "#2A2A2A"

    // Button colors
    readonly property color buttonDefault:          "#2A2A2A"
    readonly property color buttonHover:            "#363636"
    readonly property color buttonPressed:          "#1A1A1A"
    readonly property color buttonPrimary:          accentColor
    readonly property color buttonPrimaryHover:     accentColorHover
    readonly property color buttonPrimaryPressed:   accentColorPressed

    // Input field colors
    readonly property color inputBackground:        "#1A1A1A"
    readonly property color inputBorder:            "#3A3A3A"
    readonly property color inputBorderFocus:       accentColor
    readonly property color inputText:              "#FFFFFF"
    readonly property color inputPlaceholder:       "#666666"

    // ─── Spacing ──────────────────────────────────────────────────────
    readonly property real spacingXS:   4
    readonly property real spacingSM:   8
    readonly property real spacingMD:   12
    readonly property real spacingLG:   16
    readonly property real spacingXL:   24
    readonly property real spacingXXL:  32

    // ─── Corner Radius ────────────────────────────────────────────────
    readonly property real radiusXS:    4
    readonly property real radiusSM:    6
    readonly property real radiusMD:    8
    readonly property real radiusLG:    12
    readonly property real radiusXL:    16
    readonly property real radiusRound: 999   // Pill shape

    // Semantic radius aliases
    readonly property real buttonRadius:    radiusMD
    readonly property real cardRadius:      radiusLG
    readonly property real inputRadius:     radiusSM
    readonly property real dialogRadius:    radiusLG
    readonly property real tooltipRadius:   radiusSM
    readonly property real panelRadius:     radiusLG

    // ─── Shadows / Elevation ──────────────────────────────────────────
    readonly property real shadowRadius1:   8
    readonly property real shadowRadius2:   16
    readonly property real shadowRadius3:   24
    readonly property color shadowColor:    "#40000000"  // 25% black

    // ─── Animation ────────────────────────────────────────────────────
    readonly property int animFast:         120
    readonly property int animNormal:       200
    readonly property int animSlow:         350
    readonly property int animEasing:       Easing.OutCubic
    readonly property int animEasingIn:     Easing.InCubic
    readonly property int animEasingBounce: Easing.OutBack

    // ─── Opacity ──────────────────────────────────────────────────────
    readonly property real opacityDisabled: 0.38
    readonly property real opacityOverlay:  0.80
    readonly property real opacityHUD:      0.85
    readonly property real opacityShadow:   0.25

    // ─── Typography scale factors (relative to defaultFontPointSize) ──
    readonly property real fontScaleCaption:     0.75
    readonly property real fontScaleBody:        1.0
    readonly property real fontScaleSubheading:  1.15
    readonly property real fontScaleHeading:     1.35
    readonly property real fontScaleDisplay:     1.75

    // ─── HUD specific ─────────────────────────────────────────────────
    readonly property color hudBackground:      "#CC0D0D0D"
    readonly property color hudBorder:          "#33FFFFFF"
    readonly property real  hudBlurRadius:      20
    readonly property real  hudBorderWidth:     0.5
    readonly property real  hudOpacity:         0.90

    // ─── Toolbar specific ─────────────────────────────────────────────
    readonly property color toolbarBackground:  "#E6121212"
    readonly property real  toolbarBlur:        30
    readonly property real  toolbarHeight:      48

    // ─── Helper functions ─────────────────────────────────────────────
    function withOpacity(color, opacity) {
        return Qt.rgba(color.r, color.g, color.b, opacity)
    }
}
