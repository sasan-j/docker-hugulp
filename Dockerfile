FROM node:11.15.0-alpine
# Set environment variable
ARG RUN_AS=root
RUN apk update && apk add py-pygments make g++ automake autoconf libtool nasm libpng-dev make nasm && rm -rf /var/cache/apk/*

# Fix permissions so user Node can work with files
RUN chown -R node:node /home/node/

USER node

# Set NPM global install path into home directory so permissions are correct
RUN mkdir /home/node/.npm-global
RUN npm config set prefix "/home/node/.npm-global"
ENV PATH="/home/node/.npm-global/bin:${PATH}"
RUN npm i npm@latest -g
RUN npm install -g hugulp

USER root
RUN apk del py-pygments make g++ automake autoconf libtool nasm libpng-dev make nasm

CMD ["hugulp"]
