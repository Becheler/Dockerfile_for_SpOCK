FROM ubuntu:focal

LABEL maintainer="Arnaud Becheler" \
      description="Having SpOCK work in a Docker container compatible with the NASA Pleiades cluster using Singularity" \
      version="0.0.1"

# Avoid getting stuck at tzdata prompt, see https://serverfault.com/questions/949991/how-to-install-tzdata-on-a-ubuntu-docker-image
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ="America/New_York"
RUN apt-get install -y tzdata

# Update ubunutu
RUN apt-get update -y

### Avoid password problems with makefiles 'sudo mkdir' commands: see https://stackoverflow.com/questions/25845538/how-to-use-sudo-inside-a-docker-container

# Install sudo
RUN apt-get -y install --no-install-recommends sudo && apt-get clean -y

# Add a user with sudo privilegies and desactivated password
RUN adduser --disabled-password --gecos '' docker
RUN adduser docker sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Now /home/docker is a place
USER docker

# Let's always start sessions there
WORKDIR /home/docker

### SpOCK dependencies and installation

# SPock dependencies and general utilities
RUN sudo apt-get install -y --no-install-recommends\
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
      libsoil* \
    && apt-get clean -y

# Clone and build SpOCK
RUN git clone https://github.com/deflorio/SpOCK \
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

# Clean to make image smaller
RUN apt-get autoclean && \
    apt-get autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
