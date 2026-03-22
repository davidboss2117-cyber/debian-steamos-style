#!/bin/sh
exec tail -n +3 $0
# Entrada para tty en debian 13 GPUs AMD
menuentry 'Debian 13 (Consola Gaming AMD TTY)' --class debian --class gnu-linux --class os {
    load_video
    insmod gzio
    insmod part_gpt
    insmod ext2
    # Busca tu disco principal
    search --no-floppy --fs-uuid --set=root AQUI TU UUID
    echo    'Iniciando Debian 13 en TTY (Modo AMD RX)...'
    # Para que gamescope funcione bien con la gpu AMD
    linux   /vmlinuz root=UUID=AQUI TU UUID ro quiet 3 radeon.modeset=1 amdgpu.modeset=1
    echo    'Cargando ramdisk...'
    initrd  /initrd.img
}
