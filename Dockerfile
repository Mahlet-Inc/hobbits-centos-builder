FROM centos:7.2.1511

RUN head -18 /etc/yum.repos.d/CentOS-Base.repo > /etc/yum.repos.d/CentOS-72.repo \
    && sed -i 's/^#base.*/baseurl=http:\/\/vault.centos.org\/7.2.1511\/os\/x86_64\//g' /etc/yum.repos.d/CentOS-72.repo \
    && rm -f /etc/yum.repos.d/CentOS-Base.repo \
    && sed -i '/^mirror.*/d' /etc/yum.repos.d/CentOS-72.repo

RUN (curl -sL https://rpm.nodesource.com/setup_12.x | bash -) \
    && yum clean all -y \
    && yum update -y \
    && yum -y install  https://centos7.iuscommunity.org/ius-release.rpm \
    && yum group install -y "Development Tools" \
    && yum -y remove git* \
    && yum install -y fftw-devel mesa-libGL-devel python3 pkgconfig nodejs git2u-all which libxcb libxcb-devel xcb-util xcb-util-devel mesa-libGL-devel libxkbcommon-devel freetype-devel fontconfig-devel \
    && yum autoremove -y \
    && yum clean all -y

RUN curl -L -O "http://qt.mirror.constant.com/archive/qt/5.12/5.12.6/single/qt-everywhere-src-5.12.6.tar.xz" \
    && tar -xf qt-everywhere-src-5.12.6.tar.xz \
    && rm qt-everywhere-src-5.12.6.tar.xz \
    && cd qt-everywhere-src-5.12.6 \
    && ./configure -shared -confirm-license -silent -nomake examples -nomake tests -prefix /Qt -opensource -release \
    -skip qtsvg -skip qtdeclarative -skip qtactiveqt -skip qtscript -skip qtmultimedia -skip qttools \
    -skip qtxmlpatterns -skip qttranslations -skip qtdoc -skip qtlocation -skip qtsensors -skip qtconnectivity \
    -skip qtwayland -skip qt3d -skip qtimageformats -skip qtgraphicaleffects -skip qtquickcontrols -skip qtserialbus \
    -skip qtserialport -skip qtx11extras -skip qtmacextras -skip qtwinextras -skip qtandroidextras -skip qtwebsockets \
    -skip qtwebchannel -skip qtwebengine -skip qtwebview -skip qtquickcontrols2 -skip qtpurchasing -skip qtcharts \
    -skip qtdatavis3d -skip qtvirtualkeyboard -skip qtgamepad -skip qtscxml -skip qtspeech -skip qtnetworkauth \
    -skip qtremoteobjects -skip qtwebglplugin -system-freetype -qt-libpng -fontconfig\
    && gmake -j$(nproc) \
    && gmake install \
    && cd .. \
    && rm -rf qt-everywhere-src-5.12.6

ENV QMAKE_BIN /Qt/bin/qmake
ENV QT_LIB_DIR /Qt/lib
ENV QT_PLATFORMS_DIR /Qt/plugins/platforms
