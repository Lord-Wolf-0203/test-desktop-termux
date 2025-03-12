# Método Recomendado para Instalar a Helluva OS (HOS) em Dispositivos Sedona

1.  **Faça o flash da stock ROM utilizando o RSA (Rescue and Smart Assistant).**

    * Utilize o Rescue and Smart Assistant da Motorola para restaurar a stock ROM. Isso garante que seu dispositivo esteja no estado de fábrica e resolve qualquer problema com o sistema anterior.

2.  **Realize o boot temporário no TWRP com o comando:**

    ```bash
    fastboot boot /path/to/twrp.img
    ```

    * Isso carregará o TWRP temporariamente sem substituir o recovery do dispositivo.

3.  **No TWRP, faça o sideload do arquivo "copy-partitions":**

    * Execute o comando no terminal do PC:

    ```bash
    adb sideload /path/to/copy-partitions.zip
    ```

    * Esse processo é importante para garantir que as partições críticas estejam devidamente sincronizadas entre diferentes versões de firmware.

4.  **Retorne ao bootloader usando o TWRP ou manualmente com o comando:**

    ```bash
    adb reboot bootloader
    ```

5.  **No bootloader, faça o flash das partições da Helluva OS:**

    ```bash
    fastboot flash boot /path/to/boot.img
    fastboot flash dtbo /path/to/dtbo.img
    fastboot flash vendor_boot /path/to/vendor_boot.img
    ```

6.  **Depois, entre no recovery novamente (pressionando os botões de volume e power para selecionar "Recovery Mode").**

7.  **No recovery, faça o sideload da Helluva OS:**

    * Conecte o dispositivo ao PC e execute:

    ```bash
    adb sideload /path/to/HelluvaOS.zip
    ```

8.  **Após a instalação, faça um "wipe data" para evitar problemas de incompatibilidade.**

    * Isso limpará seus dados e garantirá que o sistema funcione corretamente com a Helluva OS.

9.  **Reinicie o dispositivo e aproveite a Helluva OS.**

**Observações:**

* Certifique-se de substituir `/path/to/` pelo caminho real onde os arquivos estão localizados no seu computador.
* Tenha os drivers ADB e Fastboot instalados no seu computador.
* Tenha os arquivos `twrp.img`, `copy-partitions.zip`, `boot.img`, `dtbo.img`, `vendor_boot.img` e `HelluvaOS.zip` salvos em uma pasta de fácil acesso no seu computador.
* Lembre-se de que este procedimento vai apagar todos os dados do seu dispositivo. Faça um backup antes de prosseguir.
* Siga as instruções cuidadosamente para evitar danos ao seu dispositivo.
