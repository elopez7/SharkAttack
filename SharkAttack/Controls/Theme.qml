pragma Strict
pragma Singleton
import QtQuick

QtObject {

    readonly property int width: 1440
    readonly property int height: 1080
    property bool isBigDesktopLayout: true
    property bool isSmallDesktopLayout: false
    property bool isMobileLayout: false
    property bool isSmallLayout: false

    //In here you can store your custom colors
    //Maybe there is a way to do in C++?
    // Positive Theme Colors
    readonly property color positiveBackgroundColor: Qt.color("#002C36")
    readonly property color positivePanelBackgroundColor: Qt.color("#004454")
    readonly property color positiveButtonColor         : Qt.color("#005A6F")
    readonly property color positiveHighlightColor      : Qt.color("#000D10")
    readonly property color positiveButtonPressedColor  : Qt.color("#000000")
    readonly property color black: Qt.color("#000000")


    // Negative Theme Colors
    readonly property color negativeBackgroundColor      :Qt.color("#000D10")
    readonly property color negativePanelBackgroundColor :Qt.color("#002C36")
    readonly property color negativeButtonColor          :Qt.color("#000000")
    readonly property color negativeHighlightColor       :Qt.color("#004454")
    readonly property color negativeButtonPressedColor   :Qt.color("#005A6F")
    readonly property color white: Qt.color("#ffffff")

    //spacing properties
    readonly property int spacingLarge: 64
    readonly property int spacingMedium: 32
    readonly property int spacingSmall: 16

    readonly property var smallTitleFont: {
        "family": "Roboto",
        "weight": Font.Normal,
        "italic": false,
        "pixelSize": 14
    }

    readonly property var mobileTitleFont: {
        "family": "Roboto",
        "weight": Font.Normal,
        "italic": false,
        "pixelSize": 24
    }

    readonly property var desktopTitleFont: {
        "family": "Roboto",
        "weight": Font.Normal,
        "italic": false,
        "pixelSize": 48
    }

    readonly property var desktopSubtitleFont: {
        "family": "Roboto",
        "weight": Font.Normal,
        "italic": false,
        "pixelSize": 32
    }

    readonly property font smallTitleFontObject: Qt.font(smallTitleFont)
    readonly property font mobileTitleFontObject: Qt.font(mobileTitleFont)
    readonly property font desktopTitleFontObject: Qt.font(desktopTitleFont)
    readonly property font desktopSubtitleFontObject: Qt.font(desktopSubtitleFont)

}
