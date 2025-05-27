# ICONtain
Icon container and example

## Build the container

    cd $PATH_TO_ICONtain/[cpu|gpu]_recipe
    docker build . -t icon[cpu|gpu]:v1
    
## After you built the container

### Run out of the box:

    cd $PATH_TO_ICONtain/
    docker run -v $PATH_TO_ICONtain/:/mnt/data icon[cpu|gpu]:v1

### Run interactively

Run the container

    docker run -it -it --entrypoint /bin/bash -v $PATH_TO_ICONtain/:/mnt/data  icontest:v1

Within the container

    . /opt/spack/share/spack/setup-env.sh
    spack load icon

    cd /mnt/data/example
    ./exp.jws_r2b4
    mpirun -np 2 --allow-run-as-root $(which icon)

