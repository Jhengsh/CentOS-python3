FROM centos

LABEL MAINTAINER="Jhengsh <jhengsh.email@gmail.com>"

RUN yum install -y gcc openssl-devel bzip2-devel sqlite-devel tk-devel bzip2-devel ncurses-devel gdbm-devel xz-devel tk-devel readline-devel wget make
RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz && \
    tar xzf Python-3.6.3.tgz && \
    cd Python-3.6.3 && \
    ./configure --enable-optimizations && \
    make && \
    make install

WORKDIR /root
RUN /bin/rm -r /usr/src/Python-3.6.3.tgz
CMD ["/usr/local/bin/python3"]
