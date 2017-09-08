# x11docker/xfce
# 
# Run XFCE desktop in docker. 
# Use x11docker to run image. 
# Get x11docker from github: 
#   https://github.com/mviereck/x11docker 
#
# Examples: x11docker --desktop x11docker/xfce
#           x11docker x11docker/xfce thunar 

FROM debian:stretch

RUN apt-get   update
RUN apt-get install -y apt-utils
RUN apt-get install -y dbus-x11 x11-utils x11-xserver-utils
RUN apt-get install -y procps psmisc

# OpenGL support
RUN apt-get install -y libxv1 mesa-utils mesa-utils-extra libgl1-mesa-glx libglew2.0 \
                       libglu1-mesa libgl1-mesa-dri libdrm2 libgles2-mesa libegl1-mesa

# Language/locale settings
ENV LANG=en_US.UTF-8
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/default/locale
RUN apt-get install -y locales

# some utils to have proper menus, mime file types etc.
RUN apt-get install -y --no-install-recommends xdg-utils xdg-user-dirs
RUN apt-get install -y menu menu-xdg mime-support desktop-file-utils desktop-base

# Xfce
RUN apt-get install -y --no-install-recommends xfce4 
RUN apt-get install -y xfce4-terminal mousepad xfce4-notifyd 

#RUN apt-get install -y xfce4-goodies

# includes GTK3 broadway support for HTML5 web applications
RUN apt-get install -y --no-install-recommends libgtk-3-bin

# create startscript 
RUN echo '#! /bin/bash\n\
startxfce4\n\
' > /usr/local/bin/start 
RUN chmod +x /usr/local/bin/start 

CMD start
