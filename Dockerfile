FROM ubuntu:focal

LABEL maintainer="Arnaud Becheler" \
      description="Having SpOCK work in a Docker container compatible with the NASA Pleiades cluster using Singularity" \
      version="0.0.1"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends\
                    vim \
                    sudo \
                    wget \
                    git \
                    gcc-9 \
                    g++ \
                    build-essential \
                    libboost-all-dev \
                    cmake \
                    unzip \
                    tar \
                    ca-certificates \
                    doxygen \
                    graphviz \
                    libxerces-c-dev \
                    xsdcxx \
                    gfortran \
                    freeglut3 \
                    freeglut3-dev \
                    mesa-utils \
                    libsdl2* \
                    libsoil*

# Add none root user to get sudo in makefiles dependencies work
RUN useradd admin && echo "admin:admin" | chpasswd && adduser admin sudo
USER admin

RUN sudo git clone https://github.com/deflorio/SpOCK.git \
    && cd SpOCK \
    && make install_libs \
    && make install_atmo \
    && make install_mag \
    && make orbit \
    && make sgp4 \
    && make attitude \
    && make events \
    && cd data/cspice \
    && wget ftp://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/de440.bsp
