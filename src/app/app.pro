TEMPLATE = app

TARGET = pegasus-fe

QT += qml
CONFIG += c++11 warn_on exceptions_off rtti_off

SOURCES += main.cpp

RESOURCES += \
    ../frontend/frontend.qrc \
    ../themes/themes.qrc \
    ../../assets/assets.qrc


DEFINES *= \
    QT_DEPRECATED_WARNINGS \
    QT_RESTRICTED_CAST_FROM_ASCII \
    QT_NO_CAST_TO_ASCII \
    GIT_REVISION=\\\"$$GIT_REVISION\\\"


# Deployment

unix {
    # installation is portable by default
    isEmpty(INSTALLDIR): INSTALLDIR = /opt/pegasus-frontend
    isEmpty(INSTALL_BINDIR): INSTALL_BINDIR = $${INSTALLDIR}
    isEmpty(INSTALL_DATADIR): INSTALL_DATADIR = $${INSTALLDIR}
    isEmpty(INSTALL_ICONDIR): INSTALL_ICONDIR = $${INSTALLDIR}
    isEmpty(INSTALL_DESKTOPDIR): INSTALL_DESKTOPDIR = $${INSTALLDIR}

    target.path = $${INSTALL_BINDIR}

    icons.path = $${INSTALL_ICONDIR}
    icons.extra = $${QMAKE_COPY} $$quote($${TOP_SRCDIR}/assets/icon.png) pegasus-frontend.png
    icons.files = pegasus-frontend.png

    desktop_file.input = $${TOP_SRCDIR}/etc/linux/pegasus-frontend.desktop.in
    desktop_file.output = $${OUT_PWD}/pegasus-frontend.desktop
    QMAKE_SUBSTITUTES += desktop_file
    desktop.path = $${INSTALL_DESKTOPDIR}
    desktop.files += $$desktop_file.output

    INSTALLS += icons desktop
}

!isEmpty(target.path): INSTALLS += target


# Link to the Backend (autogenerated by Qt Creator):

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../backend/release/ -lbackend
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../backend/debug/ -lbackend
else:unix: LIBS += -L$$OUT_PWD/../backend/ -lbackend

INCLUDEPATH += $$PWD/../backend
DEPENDPATH += $$PWD/../backend

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../backend/release/libbackend.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../backend/debug/libbackend.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../backend/release/backend.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../backend/debug/backend.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../backend/libbackend.a
