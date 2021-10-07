FROM centos:7.9.2009

LABEL MAINTAINER="Jhengsh <jhengsh.email@gmail.com>"
ARG PYTHON_VERSION=3.9.7

RUN yum install -y gcc openssl-devel bzip2-devel sqlite-devel tk-devel bzip2-devel ncurses-devel gdbm-devel xz-devel tk-devel readline-devel libffi-devel wget make
# RUN cd /usr/src && \
#     wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz && \
#     tar xzf Python-${PYTHON_VERSION}.tgz && \
#     cd Python-${PYTHON_VERSION} && \
#     ./configure --enable-optimizations && \
#     make && \
#     make install
# RUN /bin/rm -r /usr/src/Python-${PYTHON_VERSION}.tgz
# CMD ["/usr/local/bin/python3"]

ENV CONDA_DIR=/opt/conda \
    PATH="${CONDA_DIR}/bin:${PATH}" \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

ENV PATH="${CONDA_DIR}/bin:${PATH}"

RUN miniforge_arch=$(uname -m) && \
    miniforge_installer="Mambaforge-Linux-${miniforge_arch}.sh" && \
    wget --quiet "https://github.com/conda-forge/miniforge/releases/latest/download/${miniforge_installer}" && \
    /bin/bash "${miniforge_installer}" -f -b -p "${CONDA_DIR}" && \
    /bin/rm -f "${miniforge_installer}" && \
    ${CONDA_DIR}/bin/conda config --system --set auto_update_conda false && \
    ${CONDA_DIR}/bin/conda config --system --set show_channel_urls true && \
    ${CONDA_DIR}/bin/mamba install --quiet --yes python="${PYTHON_VERSION}"&& \
    ${CONDA_DIR}/bin/mamba list python | grep '^python ' | tr -s ' ' | cut -d ' ' -f 1,2 >> "${CONDA_DIR}/conda-meta/pinned" && \
    ${CONDA_DIR}/bin/conda update --all --quiet --yes && \
    ${CONDA_DIR}/bin/conda clean --all -f -y

WORKDIR /root
CMD ["python"]
