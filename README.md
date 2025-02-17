# automatic-lua-loader
This is an installer script that is meant to be run on a Raspberry Pi. It Loads the Lua savegame exploit automatically whenever the game is ready. You can find the Lua exploit right here: [Remote Lua Loader
](https://github.com/Leeful/leeful.github.io).


## Installation
First, you have to set your PS5's IP like this:
`export PS5_IP=10.0.0.2`
After that, you can copy and paste the following command into your Raspberry Pi's terminal via ssh. 

<br>

```sh
sudo apt update
echo $PS5_IP > ip.txt
curl -s https://raw.githubusercontent.com/BenNoxXD/automatic-lua-loader/refs/heads/main/install.sh | sudo bash
```

<br>

The Raspberry Pi will reboot after the installation, and you are ready to go. 


## Usage
It is best to connect the Raspberry Pi to one of the PS5's power ports. Now the Raspberry Pi will automatically turn on when you boot up your PS5.


## How it works
The Raspberry Pi sends a Ping to port 9026 to terminate whether the game is ready. 
When it is ready the Raspberry Pi sends the UMTX exploit followed by the elf_loader.
Now the Raspberry Pi shuts down and you are all set up. 