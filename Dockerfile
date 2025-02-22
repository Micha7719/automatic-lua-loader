FROM alpine:latest

ARG PS5_IP
ENV PYTHONUNBUFFERED=1

RUN apk update
RUN apk add git wget
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python

RUN git clone https://github.com/BenNoxXD/automatic-lua-loader/
WORKDIR /automatic-lua-loader
RUN echo $PS5_IP > ip.txt
RUN mkdir exploit
RUN wget https://raw.githubusercontent.com/shahrilnet/remote_lua_loader/refs/heads/main/payloads/umtx.lua -P exploit
RUN wget https://raw.githubusercontent.com/shahrilnet/remote_lua_loader/refs/heads/main/payloads/send_lua.py
RUN wget https://raw.githubusercontent.com/shahrilnet/remote_lua_loader/refs/heads/main/payloads/elf_loader.lua -P exploit
RUN chmod +x run.sh

CMD ["sh run.sh"]