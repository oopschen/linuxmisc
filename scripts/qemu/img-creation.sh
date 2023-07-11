basedir=$(realpath $(dirname $0))

qemu-img create -f qcow2 \
  -o preallocation=metadata,cluster_size=128k,lazy_refcounts=on \
  $basedir/win11_base.qcow2 24G

