FROM docker.io/centos:7.4.1708

ADD centos74.repo /etc/yum.repos.d/centos74.repo

RUN rm -f /etc/yum.repos.d/CentOS-Base.repo \
    && (curl -sL https://rpm.nodesource.com/setup_12.x | bash -) \
    && yum clean all -y \
    && yum -y install  https://repo.ius.io/ius-release-el7.rpm\
    && yum group install -y "Development Tools" \
    && yum -y remove git* \
    && yum install -y mesa-libGL-devel python3-devel pkgconfig nodejs git2u-all which libxcb libxcb-devel xcb-util xcb-util-devel mesa-libGL-devel libxkbcommon-devel freetype-devel fontconfig-devel \
    && yum autoremove -y \
    && yum clean all -y \
    && cat  /etc/redhat-release

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

RUN yum install -y libpcap-devel

RUN yum -y install https://packages.endpoint.com/rhel/7/os/x86_64/endpoint-repo-1.7-1.x86_64.rpm \
    && yum -y install git \
    && git --version

RUN yum install -y \
    zlib-devel \
    bzip2-devel \
    xz-devel \
    ncurses-devel \
    readline-devel \
    sqlite-devel \
    openssl-devel \
    gdbm-devel \
    libffi-devel \
    uuid-devel

RUN curl -L -O "http://www.fftw.org/fftw-3.3.8.tar.gz" \
    && tar -xf fftw-3.3.8.tar.gz \
    && rm fftw-3.3.8.tar.gz \
    && cd fftw-3.3.8 \
    && ./configure --enable-threads \
    && gmake -j$(nproc) \
    && gmake install \
    && cd .. \
    && rm -rf fftw-3.3.8

ENV PKG_CONFIG_PATH /usr/local/lib/pkgconfig