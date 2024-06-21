
## 1º Passo: Atualizar todos os pacotes e instalar alguns pacotes necessários

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

instale e faça login no Debian proot:

```sh
proot-distro install debian
proot-distro login debian
```

## 2º Passo: Instalar o gnupg e as keys para o funcionamento dos repositórios do Kali Linux

```sh
apt update
apt install gnupg -y
wget -q -O - https://archive.kali.org/archive-key.asc | gpg --dearmor -o /etc/apt/trusted.gpg.d/kali-archive-keyring.gpg
```

## 3º Passo: Editar o `sources.list` para substituir os repositórios do Debian pelos repositórios do Kali Linux

Edite o arquivo `/etc/apt/sources.list` com o seguinte comando:
```sh
nano /etc/apt/sources.list
```

Substitua o conteúdo por:
```
deb [signed-by=/etc/apt/trusted.gpg.d/kali-archive-keyring.gpg] http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware
deb [signed-by=/etc/apt/trusted.gpg.d/kali-archive-keyring.gpg] http://http.kali.org/kali kali-last-snapshot main contrib non-free non-free-firmware

# For source package access, uncomment the following line
# deb-src [signed-by=/etc/apt/trusted.gpg.d/kali-archive-keyring.gpg] http://http.kali.org/kali kali-rolling main contrib non-free non-free-firmware
# deb-src [signed-by=/etc/apt/trusted.gpg.d/kali-archive-keyring.gpg] http://http.kali.org/kali kali-last-snapshot main contrib non-free non-free-firmware
```

## 4º Passo: Atualizar todos os pacotes e corrigir alguns erros

```sh
apt update
apt upgrade -y
apt update
apt install -t kali-rolling gnupg dirmngr gpg gpg-agent gpgsm gpg-wks-client -y
apt update
apt list --upgradable
apt-get install apt -y
apt-get dist-upgrade -y
apt autoremove -y
apt update
```

## 5º Passo: Escolher e instalar a GUI

Escolha uma das GUIs abaixo e instale com os comandos correspondentes:

### GNOME
```sh
apt install kali-desktop-gnome -y
```

### XFCE4
```sh
apt install kali-desktop-xfce -y
```

### LXDE
```sh
apt install kali-desktop-lxde -y
```

### KDE Plasma
```sh
apt install kali-desktop-kde -y
```

**Nota**: O XFCE4 é o mais recomendado por ser uma GUI muito leve e ser o padrão do Kali.

## 6º Passo: Instalar o Zsh e definir como padrão (opcional)

```sh
apt update
apt install zsh zsh-theme-powerlevel9k zsh-syntax-highlighting zsh-autosuggestions fonts-powerline -y
chsh -s $(which zsh)
```

## 7º Passo: Criar o script para iniciar a GUI

Saia do proot-distro:
```sh
exit
```

Crie o script de inicialização:
```sh
nano ~/../usr/bin/kali-start
```

Adicione o conteúdo correspondente à GUI que você escolheu:

### GNOME
```sh
#!/bin/bash

kill -9 $(pgrep -f "termux.x11") 2>/dev/null

pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

sleep 3

am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

proot-distro login debian --shared-tmp -- /bin/bash -c  'export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=${TMPDIR} && service dbus start && su - kali -c "env DISPLAY=:0 gnome-shell --x11"'

exit 0
```

### XFCE4
```sh
#!/bin/bash

kill -9 $(pgrep -f "termux.x11") 2>/dev/null

pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

sleep 3

am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

proot-distro login debian --shared-tmp -- /bin/bash -c  'export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=${TMPDIR} && service dbus start && su - kali -c "env DISPLAY=:0 startxfce4"'

exit 0
```

### LXDE
```sh
#!/bin/bash

kill -9 $(pgrep -f "termux.x11") 2>/dev/null

pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

sleep 3

am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

proot-distro login debian --shared-tmp -- /bin/bash -c  'export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=${TMPDIR} && service dbus start && su - kali -c "env DISPLAY=:0 startlxde"'

exit 0
```

### KDE Plasma
```sh
#!/bin/bash

kill -9 $(pgrep -f "termux.x11") 2>/dev/null

pulseaudio --start --load="module-native-protocol-tcp auth-ip-acl=127.0.0.1 auth-anonymous=1" --exit-idle-time=-1

export XDG_RUNTIME_DIR=${TMPDIR}
termux-x11 :0 >/dev/null &

sleep 3

am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
sleep 1

proot-distro login debian --shared-tmp -- /bin/bash -c  'export PULSE_SERVER=127.0.0.1 && export XDG_RUNTIME_DIR=${TMPDIR} && service dbus start && su - kali -c "env DISPLAY=:0 startplasma-x11"'

exit 0
```

Dê permissão de execução ao script:
```sh
chmod +x ~/../usr/bin/kali-start
```

**Nota**: Esta configuração é experimental e pode conter bugs, já que estamos utilizando o Debian com repositórios e pacotes do Kali Linux.
