#/bin/bash
cd /opt/automatic-lua-loader/
while true
do
    python3 test_port.py $(cat ip.txt) 9021 15 close
    python3 test_port.py $(cat ip.txt) 9026 1 open
    sleep .5
    python3 send_lua.py $(cat ip.txt) 9026 status/running.lua
    python3 send_lua.py $(cat ip.txt) 9026 exploit/umtx.lua
    python3 send_lua.py $(cat ip.txt) 9026 status/finished.lua
    python3 send_lua.py $(cat ip.txt) 9026 exploit/elf_loader.lua
    sleep 30
done