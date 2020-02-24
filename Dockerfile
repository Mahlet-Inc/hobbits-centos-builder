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

RUN yum install -y qt5-qtbase-devel \
    && yum autoremove -y \
    && yum clean all -y

ENV QMAKE_BIN /usr/bin/qmake-qt5
ENV QT_LIB_DIR /lib64
ENV QT_PLATFORMS_DIR /usr/lib64/qt5/plugins/platforms/