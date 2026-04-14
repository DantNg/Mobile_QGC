#include "QGCPalette.h"
#include "QGCCorePlugin.h"

#include <QtCore/QDebug>

QList<QGCPalette*>   QGCPalette::_paletteObjects;

QGCPalette::Theme QGCPalette::_theme = QGCPalette::Dark;

QMap<int, QMap<int, QMap<QString, QColor>>> QGCPalette::_colorInfoMap;

QStringList QGCPalette::_colors;

QGCPalette::QGCPalette(QObject* parent) :
    QObject(parent),
    _colorGroupEnabled(true)
{
    if (_colorInfoMap.isEmpty()) {
        _buildMap();
    }

    // We have to keep track of all QGCPalette objects in the system so we can signal theme change to all of them
    _paletteObjects += this;
}

QGCPalette::~QGCPalette()
{
    bool fSuccess = _paletteObjects.removeOne(this);
    if (!fSuccess) {
        qWarning() << "Internal error";
    }
}

void QGCPalette::_buildMap()
{
    //                                      Light                 Dark
    //                                      Disabled   Enabled    Disabled   Enabled
    // DJI-inspired color palette: modern, dark, high-contrast for outdoor visibility
    DECLARE_QGC_COLOR(window,               "#F5F5F5", "#F5F5F5", "#0D0D0D", "#0D0D0D")
    DECLARE_QGC_COLOR(windowTransparent,    "#CCF5F5F5", "#CCF5F5F5", "#CC0D0D0D", "#CC0D0D0D")
    DECLARE_QGC_COLOR(windowShadeLight,     "#C0C0C0", "#A0A0A0", "#505050", "#3A3A3A")
    DECLARE_QGC_COLOR(windowShade,          "#E8E8E8", "#E0E0E0", "#1E1E1E", "#1E1E1E")
    DECLARE_QGC_COLOR(windowShadeDark,      "#D0D0D0", "#C8C8C8", "#141414", "#141414")
    DECLARE_QGC_COLOR(text,                 "#B0B0B0", "#1A1A1A", "#4A4A4A", "#FFFFFF")
    DECLARE_QGC_COLOR(warningText,          "#D32F2F", "#D32F2F", "#FF5252", "#FF5252")
    DECLARE_QGC_COLOR(button,               "#FFFFFF", "#FFFFFF", "#333333", "#2A2A2A")
    DECLARE_QGC_COLOR(buttonBorder,         "#CCCCCC", "#00D4FF", "#444444", "#444444")
    DECLARE_QGC_COLOR(buttonText,           "#B0B0B0", "#1A1A1A", "#707070", "#E0E0E0")
    DECLARE_QGC_COLOR(buttonHighlight,      "#E0E0E0", "#00D4FF", "#2A2A2A", "#00D4FF")
    DECLARE_QGC_COLOR(buttonHighlightText,  "#1A1A1A", "#000000", "#1A1A1A", "#000000")
    DECLARE_QGC_COLOR(primaryButton,        "#666666", "#00D4FF", "#444444", "#00D4FF")
    DECLARE_QGC_COLOR(primaryButtonText,    "#FFFFFF", "#000000", "#FFFFFF", "#000000")
    DECLARE_QGC_COLOR(textField,            "#FFFFFF", "#FFFFFF", "#333333", "#1A1A1A")
    DECLARE_QGC_COLOR(textFieldText,        "#999999", "#1A1A1A", "#666666", "#FFFFFF")
    DECLARE_QGC_COLOR(mapButton,            "#666666", "#1A1A1A", "#444444", "#0D0D0D")
    DECLARE_QGC_COLOR(mapButtonHighlight,   "#666666", "#00D4FF", "#444444", "#00D4FF")
    DECLARE_QGC_COLOR(mapIndicator,         "#666666", "#00D4FF", "#444444", "#00D4FF")
    DECLARE_QGC_COLOR(mapIndicatorChild,    "#666666", "#0099B8", "#444444", "#0099B8")
    DECLARE_QGC_COLOR(colorGreen,           "#2E7D32", "#2E7D32", "#00E676", "#00E676")
    DECLARE_QGC_COLOR(colorYellow,          "#F9A825", "#F9A825", "#FFD600", "#FFD600")
    DECLARE_QGC_COLOR(colorYellowGreen,     "#689F38", "#689F38", "#AEEA00", "#AEEA00")
    DECLARE_QGC_COLOR(colorOrange,          "#EF6C00", "#EF6C00", "#FF9100", "#FF9100")
    DECLARE_QGC_COLOR(colorRed,             "#C62828", "#C62828", "#FF1744", "#FF1744")
    DECLARE_QGC_COLOR(colorGrey,            "#9E9E9E", "#9E9E9E", "#B0B0B0", "#B0B0B0")
    DECLARE_QGC_COLOR(colorBlue,            "#1565C0", "#1565C0", "#448AFF", "#448AFF")
    DECLARE_QGC_COLOR(alertBackground,      "#FFD600", "#FFD600", "#FF9100", "#FF9100")
    DECLARE_QGC_COLOR(alertBorder,          "#999999", "#999999", "#666666", "#666666")
    DECLARE_QGC_COLOR(alertText,            "#000000", "#000000", "#000000", "#000000")
    DECLARE_QGC_COLOR(missionItemEditor,    "#444444", "#E0F7FA", "#444444", "#1A3A4A")
    DECLARE_QGC_COLOR(toolStripHoverColor,  "#444444", "#00B8D4", "#333333", "#1A3A4A")
    DECLARE_QGC_COLOR(statusFailedText,     "#B0B0B0", "#000000", "#4A4A4A", "#FFFFFF")
    DECLARE_QGC_COLOR(statusPassedText,     "#B0B0B0", "#000000", "#4A4A4A", "#FFFFFF")
    DECLARE_QGC_COLOR(statusPendingText,    "#B0B0B0", "#000000", "#4A4A4A", "#FFFFFF")
    DECLARE_QGC_COLOR(toolbarBackground,    "#00FFFFFF", "#00FFFFFF", "#00000000", "#00000000")
    DECLARE_QGC_COLOR(groupBorder,          "#CCCCCC", "#00B8D4", "#333333", "#333333")
    DECLARE_QGC_COLOR(modifiedParamValue,   "#EF6C00", "#EF6C00", "#FF9100", "#FF9100")

    // Colors not affecting by theming - DJI accent branding
    //                                                      Disabled     Enabled
    DECLARE_QGC_NONTHEMED_COLOR(brandingPurple,             "#4A2C6D", "#4A2C6D")
    DECLARE_QGC_NONTHEMED_COLOR(brandingBlue,               "#0099B8", "#00D4FF")
    DECLARE_QGC_NONTHEMED_COLOR(toolStripFGColor,           "#4A4A4A", "#FFFFFF")
    DECLARE_QGC_NONTHEMED_COLOR(photoCaptureButtonColor,    "#4A4A4A", "#FFFFFF")
    DECLARE_QGC_NONTHEMED_COLOR(videoCaptureButtonColor,    "#FF5252", "#FF1744")

    // Colors not affecting by theming or enable/disable
    DECLARE_QGC_SINGLE_COLOR(mapWidgetBorderLight,          "#ffffff")
    DECLARE_QGC_SINGLE_COLOR(mapWidgetBorderDark,           "#000000")
    DECLARE_QGC_SINGLE_COLOR(mapMissionTrajectory,          "#be781c")
    DECLARE_QGC_SINGLE_COLOR(surveyPolygonInterior,         "green")
    DECLARE_QGC_SINGLE_COLOR(surveyPolygonTerrainCollision, "red")

}

void QGCPalette::setColorGroupEnabled(bool enabled)
{
    _colorGroupEnabled = enabled;
    emit paletteChanged();
}

void QGCPalette::setGlobalTheme(Theme newTheme)
{
    // Mobile build does not have themes
    if (_theme != newTheme) {
        _theme = newTheme;
        _signalPaletteChangeToAll();
    }
}

void QGCPalette::_signalPaletteChangeToAll()
{
    // Notify all objects of the new theme
    for (QGCPalette *palette : std::as_const(_paletteObjects)) {
        palette->_signalPaletteChanged();
    }
}

void QGCPalette::_signalPaletteChanged()
{
    emit paletteChanged();
}
