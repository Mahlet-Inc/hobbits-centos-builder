FROM centos:7

RUN (curl -sL https://rpm.nodesource.com/setup_12.x | bash -) \
    && yum clean all -y \
    && yum update -y \
    && yum group install -y "Development Tools" \
    && yum install -y fftw-devel mesa-libGL-devel python3 pkgconfig nodejs \
    && yum autoremove -y \
    && yum clean all -y \
    && python3 -m pip install aqtinstall==0.7.1