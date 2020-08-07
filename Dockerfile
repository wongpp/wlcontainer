# =================================
# cuda          10.2
# cudnn         v7
# ---------------------------------
# python        3.8
# anaconda      5.2.0
# Jupyter       5.1 @:8888
# ---------------------------------
# Xgboost       latest(gpu)
# ---------------------------------
# tensorflow    latest (pip)
# tensorboard   latest (pip) @:6006
# tensorboardx  latest (pip)
# pytorch       latest (pip)
# torchvision   latest (pip)
# keras         latest (pip)
# pymc3         latest (pip)
# Nilearn       latest (pip)
# ---------------------------------

FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04 as base
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
        software-properties-common \
        && \
    add-apt-repository ppa:deadsnakes/ppa && \
    apt-get update && \
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
# ==================================================================
# boost
# ------------------------------------------------------------------

# ==================================================================
# chainer
# ------------------------------------------------------------------
    $PIP_INSTALL \
        cupy \
        chainer \
        && \
# ==================================================================
# jupyter
# ------------------------------------------------------------------

# some tools I used
# ------------------------------------------------------------------
    $PIP_INSTALL \
        pymc3\
        nilearn\
        mne\
        numba\
        h5py \
        nolds \
        pyhht \
        pyhrv \
        PyWavelets \
        &&\
# ------------------------------------------------------------------
# Mxnet
# ------------------------------------------------------------------

# ------------------------------------------------------------------
# pytorch
# ------------------------------------------------------------------
    $PIP_INSTALL \
        future \
        protobuf \
        enum34 \
        pyyaml \
        typing \
        && \
    $PIP_INSTALL \
        torch  torchvision pytorch-crf\
        && \

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

# =================================
# tornado version=5.1.1
# =================================

# =================================

# =================================
# cmake upgrade
# =================================

    
# =================================
# Xgboost + gpu  
# must latest cuda 
# =================================


# settings
# =================================
# set up jupyter notebook

