#! /bin/bash

python3 testport.py $(cat ip.txt)
python3 send_lua.py $(cat ip.txt) 9026 status/running.lua
python3 send_lua.py $(cat ip.txt) 9026 exploit/umtx.lua
python3 send_lua.py $(cat ip.txt) 9026 status/finished.lua
python3 send_lua.py $(cat ip.txt) 9026 exploit/elf_loader.lua