FROM ubuntu:latest


RUN apt-get update && apt-get -y upgrade

RUN apt-get install --assume-yes gcc-11
RUN apt-get install --assume-yes g++-11
RUN apt-get install --assume-yes gfortran-11
RUN apt install -y git

RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    python3 \
    python3-pip \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Clone Spack
RUN git clone https://github.com/spack/spack.git /opt/spack


RUN . /opt/spack/share/spack/setup-env.sh && \
    spack install nvhpc@25.1 && \
    spack clean -a

RUN . /opt/spack/share/spack/setup-env.sh && \
    spack install openmpi +cuda && \
    spack clean -a

RUN . /opt/spack/share/spack/setup-env.sh && \
    spack install icon@nvhpc && \
    spack clean -a


ENV PATH=$PATH:/usr/bin:/bin:/sbin

COPY ../example/entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "entrypoint.sh"]

