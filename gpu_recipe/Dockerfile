FROM ubuntu:latest

RUN apt update && apt install -yq git python3 gcc g++ gfortran cmake pkg-config curl gpg build-essential yq

RUN git clone -c feature.manyFiles=true --depth=2 --branch=develop https://github.com/spack/spack.git

RUN . /spack/share/spack/setup-env.sh && spack compiler find
RUN . /spack/share/spack/setup-env.sh && spack external find cmake gmake python perl

RUN curl https://developer.download.nvidia.com/hpc-sdk/ubuntu/DEB-GPG-KEY-NVIDIA-HPC-SDK | gpg --dearmor -o /usr/share/keyrings/nvidia-hpcsdk-archive-keyring.gpg
RUN echo 'deb [signed-by=/usr/share/keyrings/nvidia-hpcsdk-archive-keyring.gpg] https://developer.download.nvidia.com/hpc-sdk/ubuntu/arm64 /' | tee /etc/apt/sources.list.d/nvhpc.list
RUN apt update && apt install -yq nvhpc
RUN . /spack/share/spack/setup-env.sh && spack compiler find /opt/nvidia/hpc_sdk/Linux_aarch64/2025/compilers/bin
RUN yq -iy '.packages.nvhpc.externals[0].prefix = "/opt/nvidia/hpc_sdk"' /root/.spack/packages.yaml

RUN cat <<EOF > /spack.yaml
spack:
  specs:
    - icon ~ocean ~waves +mpi +mpi-gpu gpu=nvidia-90 %nvhpc
  packages:
    all:
      require:
        - +cuda cuda_arch=90
    hdf5:
      require: "%nvhpc"
    netcdf-c:
      require: "%nvhpc"
    netcdf-fortran:
      require: "%nvhpc"
    mpi:
      require: "openmpi %nvhpc"
    yaksa:
      require: "%gcc"
  view: false
  concretizer:
    unify: true
EOF

RUN . /spack/share/spack/setup-env.sh && spack -e / concretize -f
RUN . /spack/share/spack/setup-env.sh && spack -e / install --only dependencies
RUN . /spack/share/spack/setup-env.sh && spack -e / install


RUN . /spack/share/spack/setup-env.sh && spack install netcdf-fortran %nvhpc
RUN . /spack/share/spack/setup-env.sh && spack install icon -ocean +ecrad -aes +nwp %nvhpc

# TODO EXTRAS
# spack install hdf5 +mpi +hl +szip +fortran %nvhpc && \
# spack install icon -ocean -rte-rrtmgp +ecrad -aes +nwp %nvhpc && \