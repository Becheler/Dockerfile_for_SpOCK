FROM ubuntu:focal

LABEL maintainer="Arnaud Becheler" \
      description="Having SpOCK work in a Docker container compatible with the NASA Pleiades cluster using Singularity" \
      version="0.0.1"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y
RUN apt-get install -y --no-install-recommends\
                    vim \
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
                    
RUN git clone https://github.com/deflorio/SpOCK.git \
    && cd SpOCK \
    && sudo make install_libs \
    && sudo make install_atmo \
    && sudo make install_mag \
    && sudo make orbit \
    && sudo make sgp4 \
    && sudo make attitude \
    && sudo make events \
    && cd data/cspice \
    && wget ftp://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/de440.bsp
