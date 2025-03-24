# Instalação da helluvaOS (Família Sedona)

23 de março de 2025 por @Lord_Wolf_0203

## Método Recomendado para Instalar o helluvaOS (HOS) em Dispositivos Sedona

**Observações Importantes:**

* Certifique-se de substituir `/path/to/` pelo caminho real onde os arquivos estão localizados no seu computador.
* Tenha os drivers ADB e Fastboot instalados no seu computador.
* Tenha os arquivos `twrp.img`, `copy-partitions.zip`, `boot.img`, `dtbo.img`, `vendor_boot.img` e `helluvaOS.zip` salvos em uma pasta de fácil acesso no seu computador.
* Este procedimento vai apagar todos os dados do seu dispositivo. Faça um backup completo antes de prosseguir.
* Siga as instruções cuidadosamente para evitar danos ao seu dispositivo.

1.  **Restauração da ROM Stock:**

    * Utilize o Rescue and Smart Assistant da Motorola para restaurar a stock ROM. Isso garante que seu dispositivo esteja no estado de fábrica e resolve qualquer problema com o sistema anterior.

2.  **Boot Temporário no TWRP:**

    * Realize o boot temporário no TWRP com o comando:

        ```bash
        fastboot boot /path/to/twrp.img
        ```

    * Isso carregará o TWRP temporariamente sem substituir o recovery do dispositivo.

3.  **Sideload do Arquivo "copy-partitions":**

    * No TWRP, faça o sideload do arquivo "copy-partitions":
    * Execute o comando no terminal do PC:

        ```bash
        adb sideload /path/to/copy-partitions.zip
        ```

    * Esse processo é importante para garantir que as partições críticas estejam devidamente sincronizadas entre diferentes versões de firmware.
    * Retorne ao bootloader usando o TWRP.

4.  **Flash das Partições da Helluva OS:**

    * No bootloader, faça o flash das partições da Helluva OS:

        ```bash
        fastboot flash boot /path/to/boot.img
        fastboot flash dtbo /path/to/dtbo.img
        fastboot flash vendor_boot /path/to/vendor_boot.img
        ```

    * Depois, entre no recovery aosp.

5.  **Sideload da Helluva OS:**

    * No recovery, faça o sideload da Helluva OS:

        ```bash
        adb sideload /path/to/helluvaOS.zip
        ```

6.  **Wipe Data:**

    * Após a instalação, faça um "wipe data" para evitar problemas de incompatibilidade.
    * Isso limpará seus dados e garantirá que o sistema funcione corretamente com a helluvaOS.

7.  **Reiniciar e Aproveitar:**

    * Reinicie o dispositivo e aproveite a helluvaOS.
