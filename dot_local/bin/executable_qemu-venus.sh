#! /bin/env bash
set -euo pipefail

unshare --map-root-user --map-auto -- /usr/lib/virtiofsd  --translate-uid=map:1000:0:1 --translate-gid=map:1000:0:1 --socket-path=/tmp/vm-share.sock --shared-dir "${HOME}"/projects --sandbox chroot &
qemu-system-x86_64                                                       \
    -enable-kvm                                                          \
    -M q35                                                               \
    -m 16G                                                               \
    -object memory-backend-memfd,id=mem1,size=16G                        \
    -machine memory-backend=mem1                                         \
    -cpu host                                                            \
    -smp 8                                                               \
    -net nic,model=virtio                                                \
    -net user,hostfwd=tcp::2222-:22                                      \
    -device virtio-vga-gl,hostmem=4G,blob=true,venus=true                \
    -display gtk,gl=on,show-cursor=off,zoom-to-fit=on                    \
    -vga none                                                            \
    -usb -device usb-tablet                                              \
    -chardev socket,id=char0,path=/tmp/vm-share.sock                     \
    -device vhost-user-fs-pci,chardev=char0,tag=shared                   \
    -device virtio-serial-pci                                            \
    -device virtserialport,chardev=spicechannel0,name=com.redhat.spice.0 \
    -chardev spicevmc,id=spicechannel0,name=vdagent                      \
    -hda "$1" 
