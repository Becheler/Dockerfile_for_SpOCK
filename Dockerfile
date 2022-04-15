FROM ubuntu:focal

LABEL maintainer="Arnaud Becheler" \
      description="Having SpOCK work in a Docker container compatible with the NASA Pleiades cluster using Singularity" \
      version="0.0.1"

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR home/dev
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

# Get sudo makefiles dependencies work, and git clone too: see here https://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container
RUN apt-get update -y \
    && apt-get -y install --no-install-recommends sudo \
    && apt-get clean -y
    
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER docker

# RUN cd && git clone https://github.com/deflorio/SpOCK \
#    && cd SpOCK \
#    && make install_libs \
#    && make install_atmo \
#    && make install_mag \
#    && make orbit \
#    && make sgp4 \
#    && make attitude \
#    && make events \
#    && cd data/cspice \
#    && wget ftp://naif.jpl.nasa.gov/pub/naif/generic_kernels/spk/planets/de440.bsp
