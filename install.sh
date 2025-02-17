#! /bin/bash

# save IP
mv ip.txt /tmp

# install dependencies
apt-get install -y git python3 wget

# remove old version
systemctl stop lualoader
systemctl disable lualoader
rm /etc/systemd/system/lualoader.service
cd /opt
rm -r automatic-lua-loader

# install new version
git clone https://github.com/BenNoxXD/automatic-lua-loader/
cd automatic-lua-loader
mv /tmp/ip.txt /opt/automatic-lua-loader
mkdir exploit
wget https://raw.githubusercontent.com/shahrilnet/remote_lua_loader/refs/heads/main/payloads/umtx.lua -P exploit
wget https://raw.githubusercontent.com/shahrilnet/remote_lua_loader/refs/heads/main/payloads/send_lua.py
wget https://raw.githubusercontent.com/shahrilnet/remote_lua_loader/refs/heads/main/payloads/elf_loader.lua -P exploit

# create a service for autostart
cat > /etc/systemd/system/lualoader.service <<- "EOF"
[Unit]
Description=PS5 automatic lua loader

[Service]
ExecStart=/opt/automatic-lua-loader/run.sh

[Install]
WantedBy=multi-user.target
EOF

# enable the service
systemctl enable lualoader
reboot