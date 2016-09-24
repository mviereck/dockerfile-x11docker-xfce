# x11docker/xfce
# 
# Run xfce desktop in docker. 
# Use x11docker to run image. 
# Get x11docker script from github: 
#   https://github.com/mviereck/x11docker 
# Raw x11docker script:
#   https://raw.githubusercontent.com/mviereck/x11docker/e49e109f9e78410d242a0226e58127ec9f9d6181/x11docker
#
# Example: x11docker --desktop x11docker/xfce
#          x11docker --xephyr --desktop --hostuser --home --clipboard x11docker/xfce
#          x11docker -xdumc x11docker/xfce 
 
FROM phusion/baseimage:latest

RUN apt-get update

# Set environment variables 
ENV DEBIAN_FRONTEND noninteractive 
ENV LC_ALL en_US.UTF-8 
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US.UTF-8 

# fix problems with dictionaries-common 
# See https://bugs.launchpad.net/ubuntu/+source/dictionaries-common/+bug/873551 
RUN apt-get install -y apt-utils
RUN /usr/share/debconf/fix_db.pl
RUN apt-get install -y -f

RUN apt-get install -y --no-install-recommends xfce4
RUN apt-get install -y xfce4-terminal mousepad

# some useful x apps. 
RUN apt-get install -y x11-utils

## Further:
## disabled, but maybe usefull additional installations

# enable to get xrandr and some other goodies
# needed in xfce to be able to logout for wtf reasons
RUN apt-get install -y x11-xserver-utils

# OpenGl support in the dependencies
#RUN apt-get install -y mesa-utils mesa-utils-extra

# some utils to have proper menus, mime file types etc.
#RUN apt-get install -y --no-install-recommends xdg-utils
#RUN apt-get install -y menu
#RUN apt-get install -y menu-xdg
#RUN apt-get install -y mime-support
#RUN apt-get install -y desktop-file-utils

# clean cache to make image a bit smaller
RUN apt-get clean

# Set some xfce config to have visible icons
RUN mkdir -p /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml
RUN echo '<?xml version="1.0" encoding="UTF-8"?>                     \
<channel name="xsettings" version="1.0">                             \
  <property name="Net" type="empty">                                 \
    <property name="ThemeName" type="string" value="Raleigh"/>       \
    <property name="IconThemeName" type="string" value="Humanity"/>  \
  </property>                                                        \
</channel>                                                           \
' > /etc/skel/.config/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml

# create startscript 
RUN echo '#! /bin/bash                  \n\
x-session-manager                       \n\
' > /usr/local/bin/start 
RUN chmod +x /usr/local/bin/start 

CMD start
