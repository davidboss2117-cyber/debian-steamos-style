#!/bin/sh
exec tail -n +3 $0
# Entrada para tty en debian 13 para GPUs NVIDIA
menuentry 'Debian 13 (Consola Gaming NVIDIA TTY)' --class debian --class gnu-linux --class os {
    load_video
    insmod gzio
    insmod part_gpt
    insmod ext2
    # Busca tu disco principal
    search --no-floppy --fs-uuid --set=root AQUI TU UUID
    echo    'Iniciando Debian 13 en TTY con Drivers de Video...'
    # Añadimos nvidia-drm.modeset=1 para que Gamescope funcione bien con la gpu NVIDIA
    linux   /vmlinuz root=UUID=AQUI TU UUID ro quiet 3 nvidia-drm.modeset=1
    echo    'Cargando ramdisk...'
    initrd  /initrd.img
}
