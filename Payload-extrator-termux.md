*Para extrair o conteúdo de um arquivo payload.bin no Termux, você pode usar a ferramenta payload-dumper-go. Este programa permite extrair as partições contidas no arquivo payload.bin, comum em ROMs para dispositivos Android. Aqui está um guia para instalar e utilizá-lo no Termux:*

## Passo 1: Instale o Git e Go no Termux

*Primeiro, instale o Git e Go no Termux, que são necessários para clonar e compilar o payload-dumper-go:*
```sh
pkg install git golang
```
## Passo 2: Clone o repositório payload-dumper-go

*Clone o repositório oficial do payload-dumper-go no GitHub:*
```sh
git clone https://github.com/ssut/payload-dumper-go
```
## Passo 3: Compile o payload-dumper-go

*Após clonar o repositório, entre no diretório clonado e compile o programa:*
```sh
cd payload-dumper-go
go build
```
## Passo 4: Extraia o payload.bin

*Agora que o payload-dumper-go foi compilado, você pode usá-lo para extrair o arquivo payload.bin. Suponha que o arquivo payload.bin esteja no seu diretório Downloads:*
```sh
./payload-dumper-go /storage/emulated/0/Download/payload.bin
```
*O conteúdo extraído será salvo no diretório em que o comando foi executado. As partições extraídas podem incluir arquivos como boot.img, system.img, vendor.img, etc.*
