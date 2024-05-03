// Copyright (C) 2022 The Qt Company Ltd.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR BSD-3-Clause

#include "SystemTheme.h"

// If no value was inherited from a parent or explicitly set, the "global" values are used.
static SystemTheme::Theme globalTheme = SystemTheme::Light;

SystemTheme::SystemTheme(QObject *parent)
    : QQuickAttachedPropertyPropagator(parent)
    , m_theme(globalTheme)
{
    // A static function could be called here that reads globalTheme from a
    // settings file once at startup. That value would override the global
    // value. This is similar to what the Imagine and Material styles do, for
    // example.

    initialize();
}

SystemTheme *SystemTheme::qmlAttachedProperties(QObject *object)
{
    return new SystemTheme(object);
}

SystemTheme::Theme SystemTheme::theme() const
{
    return m_theme;
}

void SystemTheme::setTheme(Theme theme)
{
    // When this function is called, we know that the user has explicitly
    // set a theme on this attached object. We set this to true even if
    // the effective theme didn't change, because it's important that
    // the user's specified value is respected (and not inherited from
    // from the parent).
    m_explicitTheme = true;
    if (m_theme == theme)
        return;

    m_theme = theme;
    propagateTheme();
    themeChange();

}

void SystemTheme::inheritTheme(Theme theme)
{
    if (m_explicitTheme || m_theme == theme)
        return;

    m_theme = theme;
    propagateTheme();
    themeChange();
}

void SystemTheme::propagateTheme()
{
    const auto styles = attachedChildren();
    for (QQuickAttachedPropertyPropagator *child : styles) {
        SystemTheme *systemTheme = qobject_cast<SystemTheme *>(child);
        if (systemTheme)
            systemTheme->inheritTheme(m_theme);
    }
}

void SystemTheme::resetTheme()
{
    if (!m_explicitTheme)
        return;

    m_explicitTheme = false;
    SystemTheme *systemTheme = qobject_cast<SystemTheme *>(attachedParent());
    inheritTheme(systemTheme ? systemTheme->theme() : globalTheme);
}

void SystemTheme::themeChange()
{
    emit themeChanged();
    // Emit any other change signals for properties that depend on the theme here...
}

QColor SystemTheme::windowColor() const
{
    return m_theme == Light ? QColor::fromRgb(0xf0f0f0) : QColor::fromRgb(0x303030);
}

QColor SystemTheme::windowTextColor() const
{
    return m_theme == Light ? QColor::fromRgb(0x5c5c5c) : QColor::fromRgb(0xe0e0e0);
}

QColor SystemTheme::buttonColor() const
{
    return m_theme == Light ? QColor::fromRgb(0xc2e1ff) : QColor::fromRgb(0x74bbff);
}

QColor SystemTheme::buttonTextColor() const
{
    return m_theme == Light ? QColor::fromRgb(0x5c5c5c) : QColor::fromRgb(0xffffff);
}

QColor SystemTheme::toolBarColor() const
{
    return m_theme == Light ? QColor::fromRgb(0x4da6ff) : QColor::fromRgb(0x0066cc);
}

QColor SystemTheme::popupColor() const
{
    return windowColor().lighter(120);
}

QColor SystemTheme::popupBorderColor() const
{
    const QColor winColor = windowColor();
    return m_theme == Light ? winColor.darker(140) : winColor.lighter(140);
}

QColor SystemTheme::backgroundDimColor() const
{
    const QColor winColor = windowColor().darker();
    return QColor::fromRgb(winColor.red(), winColor.green(), winColor.blue(), 100);
}

void SystemTheme::attachedParentChange(QQuickAttachedPropertyPropagator *newParent, QQuickAttachedPropertyPropagator *oldParent)
{
    Q_UNUSED(oldParent);
    SystemTheme *attachedParentStyle = qobject_cast<SystemTheme *>(newParent);
    if (attachedParentStyle) {
        inheritTheme(attachedParentStyle->theme());
        // Do any other inheriting here...
    }
}
