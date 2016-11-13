# x11docker/xfce
# 
# Run xfce desktop in docker. 
# Use x11docker to run image. 
# Get x11docker script and x11docker-gui from github: 
#   https://github.com/mviereck/x11docker 
#
# Examples: x11docker --desktop x11docker/xfce
#           x11docker --xephyr --desktop --hostuser --home --clipboard x11docker/xfce
 
FROM ubuntu:xenial

RUN apt-get update

# Set environment variables 
ENV DEBIAN_FRONTEND noninteractive 
ENV LC_ALL en_US.UTF-8 
ENV LANG en_US.UTF-8 
ENV LANGUAGE en_US.UTF-8 
RUN locale-gen en_US.UTF-8

# fix problems with dictionaries-common 
# See https://bugs.launchpad.net/ubuntu/+source/dictionaries-common/+bug/873551 
RUN apt-get install -y apt-utils
RUN /usr/share/debconf/fix_db.pl
RUN apt-get install -y -f

# Folder must be created by root
RUN mkdir /tmp/.ICE-unix && chmod 1777 /tmp/.ICE-unix

# some utils to have proper menus, mime file types etc.
RUN apt-get install -y --no-install-recommends xdg-utils
RUN apt-get install -y menu
RUN apt-get install -y menu-xdg
RUN apt-get install -y mime-support
RUN apt-get install -y desktop-file-utils

# xterm as an everywhere working terminal
RUN apt-get install -y --no-install-recommends xterm

# pstree, killall etc.
RUN apt-get install -y psmisc



# install core xfce
RUN apt-get install -y --no-install-recommends xfce4
RUN apt-get install -y xfce4-terminal mousepad gtk3-engines-xfce

# needed in xfce to be able to logout for wtf reasons
RUN apt-get install -y x11-xserver-utils




## Further:
## Usefull additional installations, enable them if you like to

# Some xfce panel goodies
RUN apt-get install -y xfce4-whiskermenu-plugin xfce4-clipman-plugin xfce4-linelight-plugin xfce4-screenshooter-plugin xfce4-notes-plugin

#sudo
RUN apt-get install -y sudo

## some X libs for clients, f.e. allowing videos in Xephyr
#RUN apt-get install -y --no-install-recommends x11-utils

## OpenGl support in dependencies
#RUN apt-get install -y mesa-utils mesa-utils-extra

## Pulseaudio support
#RUN apt-get install -y --no-install-recommends pulseaudio



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

RUN cp -R /etc/skel/. /root/

# create startscript 
RUN echo '#! /bin/bash\n\
if [ ! -e "$HOME/.config" ] ; then\n\
  cp -R /etc/skel/. $HOME/ \n\
  cp -R /etc/skel/* $HOME/ \n\
fi\n\
xfce4-session\n\
' > /usr/local/bin/start 
RUN chmod +x /usr/local/bin/start 

CMD start
