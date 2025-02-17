#! /bin/bash

cd /opt/automatic-lua-loader/
python3 test_port.py $(cat ip.txt)
sleep .5
python3 send_lua.py $(cat ip.txt) 9026 status/running.lua
python3 send_lua.py $(cat ip.txt) 9026 exploit/umtx.lua
python3 send_lua.py $(cat ip.txt) 9026 status/finished.lua
python3 send_lua.py $(cat ip.txt) 9026 exploit/elf_loader.lua
sudo shutdown now