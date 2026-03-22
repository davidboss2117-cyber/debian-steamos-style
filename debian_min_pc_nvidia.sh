#!/bin/bash
if [ "$EUID" -ne 0 ]; then echo "Ejecuta como root"; exit 1; fi
set -e

echo "==== 1. Repositorios y Arquitectura ===="
dpkg --add-architecture i386
sed -i 's/main/main contrib non-free non-free-firmware/g' /etc/apt/sources.list
apt update
apt install -y linux-headers-amd64 dkms build-essential

echo "==== 2. Instalando Driver NVIDIA ===="
apt install -y \
nvidia-driver \
nvidia-vulkan-icd \
libglx-nvidia0 \
firmware-nvidia-gsp \
nvidia-persistenced \
libnvidia-egl-wayland1 \
xserver-xorg-video-nvidia

echo "==== 3. Instalando GNOME ===="
apt install -y \
gdm3 \
gnome-shell \
gnome-session \
dbus-user-session \
intel-microcode \
network-manager

echo "==== 4. Aplicaciones ===="
apt install -y --no-install-recommends \
gnome-terminal nautilus pciutils flatpak vulkan-tools \
loupe gnome-tweaks gnome-disk-utility gnome-system-monitor gnome-text-editor vlc

echo "==== 5. Ajustes de Arranque ASUS TUF ===="
sed -i 's/#WaylandEnable=false/WaylandEnable=false/' /etc/gdm3/daemon.conf

echo "i915" > /etc/initramfs-tools/modules
echo -e "nvidia\nnvidia_modeset\nnvidia_uvm\nnvidia_drm" >> /etc/initramfs-tools/modules

sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia-drm.modeset=1 i915.force_probe=46a6 module_blacklist=xe"/' /etc/default/grub

update-grub
update-initramfs -u
systemctl enable nvidia-persistenced
# este apartado de optimización del sistema pueden o no dejarlo, esto lo que hace es limitar el turbo boost del procesador ya que el i5 11400h en mi laptop es bastante calentón (Inicio de sección)
echo "==== 6. Optimizaciones de Sistema ===="
cat <<EOF > /etc/systemd/system/intel-turbo-limit.service
[Unit]
Description=Limitar Intel Turbo Boost al 82%
[Service]
Type=oneshot
ExecStart=/bin/sh -c 'echo 82 > /sys/devices/system/cpu/intel_pstate/max_perf_pct'
RemainAfterExit=yes
[Install]
WantedBy=multi-user.target
EOF
# este apartado de optimización del sistema pueden o no dejarlo, esto lo que hace es limitar el turbo boost del procesador ya que el i5 11400h en mi laptop es bastante calentón (Final de sección)
systemctl daemon-reload
systemctl enable intel-turbo-limit.service
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "==== 7. Instalación de Flatpaks Automática ===="
flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y flathub com.brave.Browser
flatpak update

echo "==== TODO LISTO: REINICIANDO ===="
sleep 5
reboot
