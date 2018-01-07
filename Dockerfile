FROM centos

LABEL MAINTAINER="Jhengsh"

RUN yum install -y gcc openssl-devel bzip2-devel sqlite-devel wget make
RUN cd /usr/src && \
    wget https://www.python.org/ftp/python/3.6.3/Python-3.6.3.tgz && \
    tar xzf Python-3.6.3.tgz && \
    cd Python-3.6.3 && \
    ./configure --enable-optimizations && \
    make && \
    make install

WORKDIR /root
RUN /bin/rm -r /usr/src/Python-3.6.3.tgz
CMD ["/usr/bin/python3"]
