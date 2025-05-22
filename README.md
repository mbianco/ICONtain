# ICONtain
Icon container and example

## After you built the container

Run the container

    docker run -it -v $PATH_TO_ICONtain/:/mnt/data  containername bash

Within the container

    . /opt/spack/share/spack/setup-env.sh
    spack load icon

    cd /mnt/data/example
    ./exp.jws_r2b4
    mpirun -np 2 --allow-run-as-root $(which icon)

