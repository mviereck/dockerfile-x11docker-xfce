# x11docker/xfce

Dockerfile containing XFCE desktop
 - Run XFCE desktop in docker. 
 - Use x11docker to run image to be able to run GUI applications and desktops from within docker images.
 - Get [x11docker and x11docker-gui from github](https://github.com/mviereck/x11docker)

# Example commands: 
 - `x11docker x11docker/xfce thunar`
 - `x11docker --xephyr  x11docker/xfce` 
 
 To create a container user similar to your host user and a persistent home folder preserving your settings:
 - `x11docker --xephyr --desktop --hostuser --home x11docker/xfce start`
 
 # Screenshot
 XFCE desktop in a Xephyr window running with x11docker
 ![screenshot](https://raw.githubusercontent.com/mviereck/x11docker/screenshots/screenshot-xfce.png "XFCE desktop running in Xephyr window using x11docker")
 
