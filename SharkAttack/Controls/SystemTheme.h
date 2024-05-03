#ifndef SYSTEMTHEME_H
#define SYSTEMTHEME_H

#include "qqmlintegration.h"
#include <QObject>
#include <QColor>
#include <QQuickAttachedPropertyPropagator>

class QQmlEngine;
class QJSEngine;

class SystemTheme : public QQuickAttachedPropertyPropagator
{
    Q_OBJECT
    QML_ELEMENT
    QML_ATTACHED(SystemTheme)
    QML_UNCREATABLE("")
    QML_ADDED_IN_VERSION(1, 0)

    Q_PROPERTY(Theme theme READ theme WRITE setTheme RESET resetTheme NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor windowColor READ windowColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor windowTextColor READ windowTextColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor buttonColor READ buttonColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor buttonTextColor READ buttonTextColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor toolBarColor READ toolBarColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor popupColor READ popupColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor popupBorderColor READ popupBorderColor NOTIFY themeChanged FINAL)
    Q_PROPERTY(QColor backgroundDimColor READ backgroundDimColor NOTIFY themeChanged FINAL)

public:
    enum Theme{
        Light,
        Dark
    };

    Q_ENUM(Theme)

    explicit SystemTheme(QObject *parent = nullptr);

    static SystemTheme *qmlAttachedProperties(QObject *object);

    Theme theme() const;
    void setTheme(Theme theme);
    void inheritTheme(Theme theme);
    void propagateTheme();
    void resetTheme();
    void themeChange();

    QColor windowColor() const;
    QColor windowTextColor() const;
    QColor buttonColor() const;
    QColor buttonTextColor() const;
    QColor toolBarColor() const;
    QColor popupColor() const;
    QColor popupBorderColor() const;
    QColor backgroundDimColor() const;

signals:
    void themeChanged();

protected:
    void attachedParentChange(QQuickAttachedPropertyPropagator *newParent, QQuickAttachedPropertyPropagator *oldParent) override;

private:
    bool m_explicitTheme = false;
    Theme m_theme = Light;
};

#endif // SYSTEMTHEME_H
