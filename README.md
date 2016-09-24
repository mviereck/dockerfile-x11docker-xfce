# x11docker/xfce

Dockerfile containing XFCE desktop
 - Run XFCE desktop in docker. 
 - Use x11docker to run image. 
 - Get x11docker and x11docker-gui from github: 
https://github.com/mviereck/x11docker 

# Example commands: 
 - x11docker --desktop  x11docker/xfce 
 - x11docker x11docker/xfce thunar
 - x11docker --xephyr --desktop x11docker/xfce
 - x11docker --xpra x11docker/xfce thunar
 
 To create a persistent home folder preserving your settings:
 - x11docker --xephyr --desktop --hostuser --home x11docker/xfce start
