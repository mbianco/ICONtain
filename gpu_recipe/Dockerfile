FROM nvidia/cuda:12.2.0-devel-ubuntu22.04


RUN apt-get update && apt-get -y upgrade

RUN apt-get install --assume-yes gcc-11
RUN apt-get install --assume-yes g++-11
#RUN apt-get install --assume-yes gfortran-11
#RUN apt-get install --assume-yes git

RUN apt-get update && apt-get install -y \
    git \
    curl \
    build-essential \
    python3 \
    python3-pip \
    vim \
    emacs \
    && rm -rf /var/lib/apt/lists/*

# Clone Spack
RUN git clone https://github.com/spack/spack.git /opt/spack

ENV SPACK_ROOT=/opt/spack
RUN . /opt/spack/share/spack/setup-env.sh


RUN  . /opt/spack/share/spack/setup-env.sh && \
    spack install cuda@12.9.0 && \
    spack clean -a

RUN . /opt/spack/share/spack/setup-env.sh && \
    spack install --verbose nvhpc -blas -lapack +mpi && \
    spack load nvhpc && \
    spack compiler find && \
    spack clean -a

RUN . /opt/spack/share/spack/setup-env.sh && \
    spack load nvhpc && \
    spack install --verbose hdf5 +mpi +hl %nvhpc && \
    spack clean -a


# RUN . /opt/spack/share/spack/setup-env.sh && \
#     spack install --verbose netcdf-fortran %nvhpc && \
#     spack clean -a
    
# RUN . /opt/spack/share/spack/setup-env.sh && \
#     spack install --verbose icon -ocean -rte-rrtmgp +ecrad -aes +nwp %nvhpc && \
#     spack clean -a


ENV PATH=$PATH:/usr/bin:/bin:/sbin

COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["bash", "entrypoint.sh"]

