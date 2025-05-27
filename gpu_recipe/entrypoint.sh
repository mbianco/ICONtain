
echo "Sourcing spack environment (might take few seconds)"
. /opt/spack/share/spack/setup-env.sh

echo "spack-loading icon (might take few seconds)"
spack load icon

cd /mnt/data/example

./exp.jws_r2b4

mpirun -np 2 --allow-run-as-root $(which icon)


