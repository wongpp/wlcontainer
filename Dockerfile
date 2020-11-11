# =================================

# ---------------------------------

FROM ubuntu:18.04 as base
LABEL maintainer="934685522@qq.com"

# =================================================================
# set evn
# -----------------------------------------------------------------    
RUN APT_INSTALL="apt-get install -y --no-install-recommends" && \

    PIP_INSTALL="python -m pip --no-cache-dir install --upgrade" && \
    GIT_CLONE="git clone --depth 10" && \
    apt-get update -y && \
    apt-get upgrade -y && \
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
# python 3.8
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
        pip \
        setuptools \
        && \
        
    $PIP_INSTALL \
        numpy \
        scipy \
        pandas \
        cloudpickle \
        scikit-learn \
        matplotlib \
        Cython \
        pymc3\
        nilearn\
        mne\
        numba\
        h5py \
        nolds \
        pyhht \
        pyhrv \
        xgboost  \
        openpyxl \
        pyEDFlib \
        future \
        visbrain \
        yasa \
        torch==1.7.0+cpu torchvision==0.8.1+cpu torchaudio==0.7.0 -f https://download.pytorch.org/whl/torch_stable.html \
        && \
# ==================================================================
# boost
# ------------------------------------------------------------------
#    wget -O ~/boost.tar.gz https://dl.bintray.com/boostorg/release/1.65.1/source/boost_1_65_1.tar.gz && \
#    tar -zxf ~/boost.tar.gz -C ~ && \
#    cd ~/boost_* && \
#    ./bootstrap.sh --with-python=python3.6 && \
#    ./b2 install --prefix=/usr/local && \
# ==================================================================
# chainer
# ------------------------------------------------------------------
#    $PIP_INSTALL \
#        cupy \
#       chainer \
#        && \
# ==================================================================
# jupyter
# ------------------------------------------------------------------
#    $PIP_INSTALL \
#        jupyter \
#        && \
        
# some tools I used
# ------------------------------------------------------------------


# ------------------------------------------------------------------
# Mxnet
# ------------------------------------------------------------------
#    $PIP_INSTALL \
#        mxnet-cu100\
#        autogluon\
#        &&\
# ------------------------------------------------------------------
# pytorch
# ------------------------------------------------------------------
#    $PIP_INSTALL \
#        future \
#        numpy \
#        protobuf \
#        enum34 \
#        pyyaml \
#       typing \
#       && \
#   $PIP_INSTALL \
#       torch -f https://download.pytorch.org/whl/nightly/cu100/torch.html \
#       && \
# ==================================================================
# tensorflow
# ------------------------------------------------------------------
#    $PIP_INSTALL \
#        tensorflow-gpu \
#        && \
# ==================================================================
# tensorboradx and torchvision
# ------------------------------------------------------------------      
#    $PIP_INSTALL \
#        torchvision\
#        tensorboardx\
#        && \
# ==================================================================
# keras
# ------------------------------------------------------------------
#    $PIP_INSTALL \
#        h5py \
#        keras \
#        && \
# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
    ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
    
# =================================
# tini
# =================================
#RUN apt-get install -y curl grep sed dpkg && \
#    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
#    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
#    dpkg -i tini.deb && \
#    rm tini.deb && \
#    apt-get clean

# =================================
# tornado version=5.1.1
# =================================
#RUN pip install --upgrade tornado==5.1.1
# =================================

# =================================
# cmake upgrade
# =================================
#RUN apt remove -y --purge --auto-remove cmake  && \
#    wget https://cmake.org/files/v3.17/cmake-3.17.0-Linux-x86_64.tar.gz   && \
#    tar -zxvf cmake-3.17.0-Linux-x86_64.tar.gz   && \
#    mv cmake-3.17.0-Linux-x86_64 /opt/cmake-3.17.0  && \
#    ln -sf /opt/cmake-3.17.0/bin/*  /usr/bin/      && \
#    cmake --version   

    
# =================================
# Xgboost + gpu  
# must latest cuda 
# =================================
#RUN git clone --recursive https://github.com/dmlc/xgboost  && \
#    cd xgboost  && \
#    mkdir build  && \
#    cd build  && \
#    cmake .. -DUSE_CUDA=ON  && \
#    make -j4  && \
#    cd ..   && \
#    cd python-package   && \	
#    python setup.py install



# =================================
# set up jupyter notebook
#COPY jupyter_notebook_config.py /root/.jupyter/
#EXPOSE 8888 6006
#RUN mkdir /notebook
#ENTRYPOINT [ "/usr/bin/tini", "--" ]
#CMD ["jupyter", "notebook", "--no-browser", "--allow-root"]
#WORKDIR /notebook
