
# ---------------------------------

FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04 as base
LABEL maintainer="934685522@qq.com"

RUN apt-get update
# =================================================================
# set evn
# -----------------------------------------------------------------    
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \
    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get update && \
    
# ==================================================================
# tools
# ------------------------------------------------------------------
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        build-essential \
        apt-utils \
        ca-certificates \
        cmake \
        curl \
        wget \
        git \
        vim \
        && \ 
        
# ==================================================================
# python
# ------------------------------------------------------------------
    
    DEBIAN_FRONTEND=noninteractive $APT_INSTALL \
        python3.8 \
        python3.8-dev \
        python3-distutils-extra \
        && \
        
    wget -O ~/get-pip.py \
        https://bootstrap.pypa.io/get-pip.py && \
        
    python3.8 ~/get-pip.py && \
    ln -s /usr/bin/python3.8 /usr/local/bin/python3 && \
    ln -s /usr/bin/python3.8 /usr/local/bin/python && \
    
    $PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        scikit-learn \
        matplotlib \
        Cython \
        && \

    $PIP_INSTALL \
        numba\
        h5py \
        nolds \
        pyhht \
        pyhrv \
        &&\

    $PIP_INSTALL \
        torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html \
        && \

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*


