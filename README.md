# x11docker/xfce

Base image XFCE desktop (on debian stretch)
 - Run XFCE desktop in docker.
 - Use x11docker to run image to run GUI applications and desktop environments in docker images.
 - Get [x11docker from github](https://github.com/mviereck/x11docker)

# Example commands: 
 - Single application: `x11docker x11docker/xfce thunar`
 - Full desktop: `x11docker --desktop x11docker/xfce` 
  
# Extend base image to fit your needs
To add your desired applications, create your own Dockerfile `mydockerfile` with this image as a base. Example:
```
FROM x11docker/xfce
RUN apt-get update
RUN apt-get install -y firefox
```
 - Build an image with `docker build -t myxfce - < mydockerfile`. 
 - Run desktop with `x11docker --desktop myxfce` or firefox only with `x11docker myxfce firefox`.

 # Screenshot
 XFCE desktop in a Xephyr window running with x11docker:
 
 ![screenshot](https://raw.githubusercontent.com/mviereck/x11docker/screenshots/screenshot-xfce.png "XFCE desktop running in Xephyr window using x11docker")
 

