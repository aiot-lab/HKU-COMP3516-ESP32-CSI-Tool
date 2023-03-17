# ESP32 Data Collection Manual
This tool is based on [Github repo: ESP32-CSI-Tool](https://github.com/StevenMHernandez/ESP32-CSI-Tool).
## Requirement

We setup ESP in STA(station)-AP(Access Point) mode, by analysing CSI in-between, activities around STA-AP can be detected.

1. **STA**: ESP32-S3-DevKitC-1 v1.0
2. **AP**: A router with known password (e.g. your mobile phone hotspot)
3. micro-USB cable (connecting ESP32 to your computer).
4. Personal Computer (1 USB port) 

![](fig/esp-usb.jpg)

*Due to platform differences, some examples may only work in MacOS and Linux terminal. For Windows Users, please run all scripts in `PowerShell`.
## ESPRESSIF Dev Kit installation (VS Code)
ESP-IDF on VS code is one of several methods to develop ESP32. Here are the steps:

1. Install **[Visual Studio Code](https://code.visualstudio.com/download)**, **[git](https://github.com/git-guides/install-git)**, **python** on your computer.
2. Install required extensions for VS Code.
   1. Espressif IDF v1.6.0
   2. python, python environment manager, jupyter

<p align="center"><img src="fig/vscode_extensions.jpg" width=50% height=""></p>


### Configure ESP-IDF
1. Upon Installation, a new window for ESP-IDF will pop up. Or you can open it from View$\rightarrow$Command Palette$\rightarrow$*ESP-IDF: Configure ESP-IDF extension*. 
<p align="center"><img src="fig/homepage_IDF_install.jpg" width=50% height=""></p>

2. Click `Advanced`
3. For ESP-IDF version, **choose `v4.4.4 (release version)`**; Leave other settings with default value.
<p align="center"><img src="fig/tool_setup.jpg" width=50% height=""></p>

4. Continue. Download tools.
<p align="center"><img src="fig/tool_download.jpg" width=50% height=""></p>

5. Compelte downloading. If there shows additional requirement for USB configuration, just do it.
<p align="center"><img src="fig/tool_end.jpg" width=50% height=""></p>

### Setup VS code workspace
(Open folder:active_sta in VS code)
1. Connect ESP32 via USB port on you PC.
2. On the bottom bar of VSCode. Select ESP port. It's name may depend on your own device.
![](fig/tool_bar_port.jpg)
3. Select ESP Devices: active_sta(folder) > esp32s3 > ESP32-S3 Chip(via ESP-PROG)
![](fig/tool_bar_dev.jpeg)
4. Click ESP-IDF Configuration editor
![](fig/tool_bar_config.jpeg)
   1. enable CSI feature
   2. set (SSID, password) of your personal Hotspot (or any WiFi with password, **CANNOT use HKU or WiFi.HKU via HKU**)
   3. set TX rate(1000Hz)
   4. enable CSI report
   5. enable sending CSI to serial port. (All settings see below)
![](fig/enable_CSI.jpg)
![](fig/enable_CSI_collecting_to_serial.jpg)
1. Build, Compile and Flash! A monitor will show up if all work fine.
![](fig/tool_bar_start.jpg)
![](fig/build.jpg)
![](fig/flash.jpg)
![](fig/monitor.jpg)

1. Make sure your hotspot is active when ESP32 finishes booting.
Once connected, ESP32 will dump CSI through serial monitor, i.e. you VS Code terminal.
If not, ESP32 will keep waiting
![](fig/start_wait.jpg)

1. Exit Monitor by `Ctrl+]`

## Data Collection
### Write a script to start terminal monitor
Previously, we are using VS code to help us bring up a monitor for ESP32 output. To collect data from ESP32 output, we can simply do as VS code does. First of all, we should know what VS code does when it starts a monitor.

Steps:
1. Click Monitor on bottom bar.
![](fig/tool_bar_monitor.jpg)
2. Exit Monitor mode when a few lines show up.
3. Copy the first few lines as a start_monitor.sh file.
![](fig/monitor_script.jpg)
Run in any terminal by typing `sh start_monitor.sh`.
4. Collect CSI by running:
```bash
# sh start_monitor.sh | grep <keywords> > <your-filename>
# macOS or Linux
sh start_monitor.sh | grep "CSI_DATA" > data/my-experiment-file.csv

# Windows
sh start_monitor.sh | findstr "CSI_DATA" > data/my-experiment-file.csv 
```
![](fig/csv_sample.jpg)
5. CSI data will be saved as CSV file with all available fields ([descriptions](https://github.com/espressif/esp-idf/blob/9d0ca60398481a44861542638cfdc1949bb6f312/components/esp_wifi/include/esp_wifi_types.h#L310)), including type,role,mac,rssi,rate,sig_mode,mcs,bandwidth,smoothing,not_sounding,aggregation,stbc,fec_coding,sgi,noise_floor,ampdu_cnt,channel,secondary_channel,**local_timestamp**,ant,sig_len,rx_state,real_time_set,real_timestamp. 
   
We will parse CSI data from it later in Jupyter notebook. 
   
## Basic data Processing

See `python_util/parse_csi.ipynb`

## Other useful material
1. [ESP-IDF Official Doc for ESP32-S3](https://docs.espressif.com/projects/esp-idf/en/release-v4.4/esp32s3/get-started/index.html)
2. [ESP32-CSI-Tool Github](https://github.com/StevenMHernandez/ESP32-CSI-Tool)
3. [ESP-IDF CSI Description](https://docs.espressif.com/projects/esp-idf/en/latest/esp32/api-guides/wifi.html?highlight=csi#wi-fi-channel-state-information)