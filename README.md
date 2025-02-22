# automatic-lua-loader
This is an installer script that Loads the PS5 UMTX Lua savegame exploit and the elf_loader automatically whenever the game is ready. You can install it natively (eg. on a Raspberry Pi) or in a Docker container. You can find the Lua exploit right here: [Remote Lua Loader](https://github.com/shahrilnet/remote_lua_loader).


## How it works
1. Your device checks if port 9026 is open to terminate whether the game is ready. 
2. It sends the UMTX exploit followed by the elf_loader.
3. It waits until the ELF loader/port 9021 is closed to start the process all over again. 


## Native installation
First, you have to set your PS5's IP like this:
<br>

```sh
export PS5_IP=10.0.0.2
```

<br>
After that, you can copy and paste the following command into your terminal (eg. via ssh). You can also use this command to update the UMTX & elf_loader payload.

<br>

```sh
sudo apt update
echo $PS5_IP > ip.txt
curl -s https://raw.githubusercontent.com/BenNoxXD/automatic-lua-loader/refs/heads/main/install.sh | sudo bash
```

<br>

Your Raspberry Pi/server will reboot after the installation, and you are ready to go. 

# Usage
If you are using a Paspberry Pi it is best to connect it to one of the PS5's power ports. Now the Raspberry Pi will automatically turn on whenever your PS5 boots up. 

## Docker installation
First, you have to set your PS5's IP like this:
<br>

```sh
export PS5_IP=10.0.0.2
```

<br>
Make sure you have [Docker](https://docs.docker.com/engine/install/) installed. You can check it like this: docker -v.
Now you can download this Dockerfile:
<br>

```sh
wget https://raw.githubusercontent.com/BenNoxXD/automatic-lua-loader/refs/heads/main/Dockerfile
```

<br>
Then run the following command to create the image and deploy the container:
<br>

```sh
docker build --build-arg PS5_IP=$PS5_IP -t automatic-lua-loader .
docker run -d -t --name PS5-Lua-Loader --restart always automatic-lua-loader
```

<br>