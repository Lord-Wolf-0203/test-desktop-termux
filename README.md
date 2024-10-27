# Termux desktop
**nota**: isso e apenas um repositório aonde um cara aleatório posta tutoriais duvidosos sobre distro linux no termux.
### pacotes ultilizados no termux

```sh
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
```
### xfce4 com mesa-vulkan-dri3 nativo no termux (adreno)

```sh
curl -sL https://raw.githubusercontent.com/Lord-Wolf-0203/test-desktop-termux/refs/heads/main/install-xfce4-zink.sh -o install-xfce4-zink.sh && chmod +x install-xfce4-zink.sh && ./install-xfce4-zink.sh
```

### erro signal 9 no termux 
**se você estiver no Android 12+ vai ser necessário usar comandos adb para desativar o Phantom process killer**

```sh
adb shell "/system/bin/device_config set_sync_disabled_for_tests persistent"
adb shell "/system/bin/device_config put activity_manager max_phantom_processes 2147483647"
adb shell settings put global settings_enable_monitor_phantom_procs false
```
