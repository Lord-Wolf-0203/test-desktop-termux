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

# Passo 2: Instalação do XFCE4 e Mesa Vulkan
echo "Instalando XFCE4 e pacotes adicionais..."
apt install xfce4 -y
apt install xfce4-goodies -y
apt install firefox -y
apt install mesa-vulkan-icd-freedreno-dri3 -y

# Passo 3: Criação do Script de Inicialização
echo "Criando script de inicialização para o XFCE4 com Zink..."

cat > ~/../usr/bin/start << 'EOF'
#!/bin/bash

XDG_RUNTIME_DIR=${TMPDIR} termux-x11 :1.0 &
sleep 1
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1
DISPLAY=:1.0 MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink TU_DEBUG=noconform dbus-launch --exit-with-session xfce4-session & > /dev/null 2>&1
EOF

# Tornando o script executável
chmod +x ~/../usr/bin/start
rm Install.sh

echo "Instalação concluída. Use o comando 'start' para iniciar o XFCE4 com Zink."
