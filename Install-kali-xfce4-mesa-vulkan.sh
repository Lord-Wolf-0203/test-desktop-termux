#!/bin/bash

# Passo 1: Configuração Inicial
echo "Configurando armazenamento e atualizando pacotes..."
termux-setup-storage
apt update
apt upgrade -y
pkg install x11-repo -y
pkg install termux-x11-nightly -y
pkg install tur-repo -y
pkg install pulseaudio -y
pkg install proot-distro -y
pkg install wget -y
pkg install git -y

# Passo 2: Configurando o proot para instalar o Kali NetHunter
cat > $PREFIX/etc/proot-distro/kali.sh << 'EOF'
# kali nethunter aarch64
DISTRO_NAME="Kali Linux (Rolling)"
DISTRO_COMMENT="Kali Linux nethunter aarch64"

TARBALL_URL['aarch64']="http://kali.download/nethunter-images/current/rootfs/kali-nethunter-rootfs-nano-arm64.tar.xz"
TARBALL_SHA256['aarch64']="a1624e4bb2423dee6e9806455dc963a32d6cbbcbe2d4ac008826d0fd7fe1e773"
TARBALL_STRIP_OPT='2'
EOF

# Passo 3: Instalando o kali
echo "Instalando o Kali..."
proot-distro install kali
proot-distro login kali --shared-tmp
apt update
apt full-upgrade -y
apt autoremove -y
apt install apt-utils -y


# Passo 4: Instalação do Mesa Vulkan
echo "Instalando o Mesa Vulkan..."
wget https://github.com/Lord-Wolf-0203/test-desktop-termux/raw/refs/heads/main/mesa-vulkan-kgsl_24.1.0-devel-20240120_arm64.deb
apt install libllvm15 -y
dpkg -i mesa-vulkan-kgsl_24.1.0-devel-20240120_arm64.deb

# Passo 5: Instalação do XFCE4
echo "Instalando o XFCE4..."
apt install kali-desktop-xfce4 -y
exit
# Passo 6: Criação do Script de Inicialização
echo "Criando o script de inicialização..."
cat > ~/../usr/bin/start << 'EOF'
#!/bin/sh
killall -9 termux-x11 pulseaudio virgl_test_server_android
termux-wake-lock; termux-toast "Starting Kali Linux"

# Termux-X11 start
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity
df | grep /storage | cut -d "/" -f 4-
# X11 start
XDG_RUNTIME_DIR=${TMPDIR} termux-x11 :0 -ac -extension MIT-SHM &
sleep 3

# Audio server
pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1
pacmd load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1

# Linux login
touch ~/something
proot-distro login --bind ~/something:/proc/bus/pci/devices kali --shared-tmp --no-sysvipc -- "export DISPLAY=:0 PULSE_SERVER=tcp:127.0.0.1:4713; MESA_NO_ERROR=1 MESA_LOADER_DRIVER_OVERRIDE=zink TU_DEBUG=noconform MESA_GL_VERSION_OVERRIDE=4.6COMPAT MESA_GLES_VERSION_OVERRIDE=3.2 dbus-launch --exit-with-session startxfce4"
EOF

chmod +x ~/../usr/bin/start
rm install.sh

echo "Instalação concluída. Use o comando 'start' para iniciar o Kali Linux com XFCE4."
