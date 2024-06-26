// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

import QtQuick
import QtQuick.Templates as T

import SharkAttack.Controls

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    horizontalPadding: padding + 2
    spacing: 6

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.SystemTheme.buttonTextColor
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        implicitWidth: 60
        implicitHeight: 40
        radius: 90
        color: control.down ? Qt.darker(control.SystemTheme.buttonColor, 1.1) : control.SystemTheme.buttonColor
    }
}
