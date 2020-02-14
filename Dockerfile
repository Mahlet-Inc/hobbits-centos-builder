FROM centos:7

RUN yum update -y \
    && yum group install -y "Development Tools" \
    && yum install -y fftw-devel mesa-libGL-devel python3 pkgconfig \
    && python3 -m pip install aqtinstall