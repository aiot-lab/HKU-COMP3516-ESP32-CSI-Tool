#!/bin/bash
export IDF_PATH=/Users/Halloween/esp/esp-idf
/Users/Halloween/.espressif/python_env/idf4.4_py3.7_env/bin/python /Users/Halloween/esp/esp-idf/tools/idf_monitor.py -p /dev/cu.usbserial-10 -b 115200 --toolchain-prefix xtensa-esp32s3-elf- --target esp32s3 /Users/Halloween/Documents/Octosense/esp32-csi-tool/active_sta/build/active-sta.elf