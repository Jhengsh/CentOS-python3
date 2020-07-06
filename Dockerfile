FROM centos:7.8.2003

LABEL MAINTAINER="Jhengsh <jhengsh.email@gmail.com>"

RUN yum install -y gcc openssl-devel bzip2-devel sqlite-devel tk-devel bzip2-devel ncurses-devel gdbm-devel xz-devel tk-devel readline-devel libffi-devel wget make
RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/3.7.8/Python-3.7.8.tgz && \
    tar xzf Python-3.7.8.tgz && \
    cd Python-3.7.8 && \
    ./configure --enable-optimizations && \
    make && \
    make install

WORKDIR /root
RUN /bin/rm -r /usr/src/Python-3.7.8.tgz
CMD ["/usr/local/bin/python3"]
