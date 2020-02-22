FROM centos:7.2.1511

RUN (curl -sL https://rpm.nodesource.com/setup_12.x | bash -) \
    && yum clean all -y \
    && yum update -y \
    && yum group install -y "Development Tools" \
    && yum install -y fftw-devel mesa-libGL-devel python3 pkgconfig nodejs \
    && yum autoremove -y \
    && yum clean all -y \
    && python3 -m pip install aqtinstall==0.7.1

RUN yum -y remove git* \
    && yum -y install  https://centos7.iuscommunity.org/ius-release.rpm \
    && yum -y install  git2u-all

ADD qt5 /qt5

RUN cd /qt5 \
    && curl -L -O "https://download.qt.io/official_releases/qt/5.12/5.12.6/qt-opensource-linux-x64-5.12.6.run" \
    && cat /etc/resolv.conf > /etc/resolv.conf.nope \
    && echo "" > /etc/resolv.conf \
    && chmod +x qt-opensource-linux-x64-5.12.6.run \
    && ./qt-opensource-linux-x64-5.12.6.run --platform minimal --script cli-install-script.qs --verbose --no-proxy \
    && rm qt-opensource-linux-x64-5.12.6.run \
    && cat /etc/resolv.conf.nope > /etc/resolv.conf \
    && rm /etc/resolv.conf.nope

ENV QTDIR /Qt/5.12.6/gcc_64