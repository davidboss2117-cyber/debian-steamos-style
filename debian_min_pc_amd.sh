#!/bin/bash
# Verificar root
if [ "$EUID" -ne 0 ]; then
  echo "Ejecuta este script como root o con sudo"
  exit 1
fi

set -e
export DEBIAN_FRONTEND=noninteractive

echo "==== 1. Configurando repositorios ===="
sed -i 's/main$/main contrib non-free non-free-firmware/' /etc/apt/sources.list
apt update

echo "==== 2. Habilitando arquitectura 32 bits (Steam) ===="

if ! dpkg --print-foreign-architectures | grep -q i386; then
  dpkg --add-architecture i386
fi

apt update


echo "==== 3. Microcódigo y Drivers AMD ===="

apt install -y \
amd64-microcode \
firmware-amd-graphics \
mesa-vulkan-drivers \
mesa-va-drivers \
mesa-vdpau-drivers \
libgl1-mesa-dri \
libglx-mesa0 \
mesa-utils \
vulkan-tools \
libvulkan1 \
libvulkan1:i386 \
libgl1-mesa-dri:i386 \
mesa-vulkan-drivers:i386

apt autoremove -y
apt clean

echo "==== 4. GNOME MINIMO ===="

apt install -y \
gdm3 \
gnome-shell \
gnome-session \
gnome-settings-daemon \
gnome-control-center \
gnome-terminal \
nautilus \
dbus-user-session \
network-manager \
network-manager-gnome \
xdg-user-dirs \
xdg-desktop-portal \
xdg-desktop-portal-gnome \
polkitd \
pipewire \
pipewire-audio \
pipewire-pulse \
wireplumber \
fonts-cantarell \
adwaita-icon-theme \
pipewire-alsa \
gnome-keyring

apt autoremove -y
apt clean

echo "==== 5. Software base ===="

apt install -y \
gnome-disk-utility \
baobab \
loupe \
corectrl \
gnome-tweaks \
flatpak \
fonts-dejavu \
fastfetch \
gnome-system-monitor \
gnome-text-editor \
vlc

apt autoremove -y
apt clean

echo "==== 6. Configurando Flatpak ===="

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo


echo "==== 8. Apps Flatpak ===="

flatpak install -y flathub \
com.github.tchx84.Flatseal \
com.brave.Browser || true

echo "==== 9. Optimizaciones del sistema ===="

cat <<EOF > /etc/sysctl.d/99-gaming.conf
kernel.sched_autogroup_enabled=0
vm.swappiness=10
vm.dirty_ratio=15
vm.dirty_background_ratio=5
EOF

sysctl --system


echo "==== 10. CoreCtrl para RDENA en adelante ===="

if ! grep -q amdgpu.ppfeaturemask /etc/default/grub; then
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="/GRUB_CMDLINE_LINUX_DEFAULT="amdgpu.ppfeaturemask=0xffffffff /' /etc/default/grub
update-grub
fi

usermod -aG video $SUDO_USER


echo "==== 11. Servicios ===="

systemctl enable --now gdm3
systemctl enable --now NetworkManager


echo "==== 12. Limpieza del sistema ===="

apt purge -y gnome-backgrounds desktop-base
apt autoremove -y
apt clean
apt-mark hold gnome-backgrounds desktop-base
rm -rf /usr/share/backgrounds/*

echo "==== Instalación terminada ===="
sleep 3
reboot
