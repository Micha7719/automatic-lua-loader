# automatic-lua-loader
This is an installer script that Loads the PS5 UMTX Lua savegame exploit and the elf_loader automatically whenever the game is ready. You can install it natively (eg. on a Raspberry Pi) or in a Docker container. You can find the Lua exploit right here: [Remote Lua Loader](https://github.com/shahrilnet/remote_lua_loader).


## How it works
There are multiple installation configurations you can combine.
One is the kill game option. When enabled: The server automatically sends a Payload to the PS5 after the elfdr is loaded, which kills the game process. 
Another option is the continue option. Here you can decide what your server will do after the exploit is loaded. You can choose between shutdown and ping. When ping is selected your server will wait until the elfdr isn't running anymore and then start the process again. 

In short:
1. Your device checks if port 9026 is open to terminate whether the game is ready. 
2. It sends the UMTX exploit followed by the elf_loader.
3. (optionally) sends a Killgame Payload.
4. It waits until the ELF loader/port 9021 is closed to start the process all over again OR your server will shut down. 


## Native installation
You can just copy and paste the following command into your terminal (eg. via ssh). You can also use this command to update the UMTX & elf_loader payload.
Here is the command syntax: 

`./install.sh -ps5_ip=YOURPS5IP [-killgame=on|off] [-continue=shutdown|ping]`

And here is the command install command with an example config: 
<br>

```sh
sudo apt update
wget https://raw.githubusercontent.com/BenNoxXD/automatic-lua-loader/refs/heads/main/install.sh
sudo chmod +x install.sh
sudo ./install.sh -ps5_ip=10.0.0.2 -killgame=on -continue=ping
```

<br>

# Usage
If you are using a Paspberry Pi it is best to connect it to one of the PS5's power ports. Now the Raspberry Pi will automatically turn on whenever your PS5 boots up. 


## Docker installation
Make sure you have [Docker](https://docs.docker.com/engine/install/) installed. You can check it like this: `docker -v`.
Now you can download this Dockerfile:
<br>

```sh
wget https://raw.githubusercontent.com/BenNoxXD/automatic-lua-loader/refs/heads/main/Dockerfile
```

<br>

Then run the following command to create the image and deploy the container.
<br>

```sh
docker build \
--build-arg ps5_ip=10.0.0.2 \
--build-arg killgame=on \
--build-arg continue=ping \
-t automatic-lua-loader .

docker run -d -t --name PS5-Lua-Loader --restart always automatic-lua-loader
```

<br>
