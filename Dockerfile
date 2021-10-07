FROM centos:7.9.2009

LABEL MAINTAINER="Jhengsh <jhengsh.email@gmail.com>"
ARG PYTHON_VERSION=3.9.7

RUN yum install -y gcc openssl-devel bzip2-devel sqlite-devel tk-devel bzip2-devel ncurses-devel gdbm-devel xz-devel tk-devel readline-devel libffi-devel wget make
RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
    tar xzf Python-${PYTHON_VERSION}.tgz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure && \
    make && \
    make install
RUN /bin/rm -r /usr/src/Python-${PYTHON_VERSION}.tgz
CMD ["/usr/local/bin/python3"]