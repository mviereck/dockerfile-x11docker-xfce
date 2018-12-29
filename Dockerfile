# x11docker/xfce
# 
# Run XFCE desktop in docker. 
# Use x11docker to run image. 
# Get x11docker from github: 
#   https://github.com/mviereck/x11docker 
#
# Examples: 
#   - Run desktop:
#       x11docker --desktop x11docker/xfce
#   - Run single application:
#       x11docker x11docker/xfce thunar
#
# Options:
# Persistent home folder stored on host with   --home
# Shared host folder with                      --sharedir DIR
# Hardware acceleration with option            --gpu
# Clipboard sharing with option                --clipboard
# Sound support with option                    --alsa
# With pulseaudio in image, sound support with --pulseaudio
# Language setting with                        `--lang=$LANG`
# Printing over CUPS with                      `--printer`
# Webcam support with                          `--webcam`
#
# Look at x11docker --help for further options.

FROM debian:buster
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get  update && apt-mark hold iptables && \
    apt-get install -y dbus-x11 procps psmisc x11-utils x11-xserver-utils kmod xz-utils

# Language/locale settings
# replace en_US by your desired locale setting, 
# for example de_DE for german.
ENV LANG en_US.UTF-8
RUN echo $LANG UTF-8 > /etc/locale.gen && \
    apt-get install -y locales && update-locale --reset LANG=$LANG

# some utils to have proper menus, mime file types etc.
RUN apt-get install -y --no-install-recommends xdg-utils xdg-user-dirs \
    menu-xdg mime-support desktop-file-utils

# Xfce
RUN apt-get install -y --no-install-recommends xfce4 && \
    apt-get install -y --no-install-recommends gtk3-engines-xfce xfce4-notifyd \
      mousepad xfce4-taskmanager xfce4-terminal libgtk-3-bin && \
    apt-get install -y --no-install-recommends xfce4-battery-plugin \
      xfce4-clipman-plugin xfce4-cpugraph-plugin xfce4-datetime-plugin \
      xfce4-netload-plugin xfce4-notes-plugin xfce4-places-plugin \
      xfce4-sensors-plugin xfce4-systemload-plugin \
      xfce4-whiskermenu-plugin xfce4-indicator-plugin \
      xfce4-cpufreq-plugin xfce4-diskperf-plugin xfce4-fsguard-plugin \
      xfce4-genmon-plugin xfce4-smartbookmark-plugin xfce4-timer-plugin \
      xfce4-verve-plugin xfce4-weather-plugin

# OpenGL support
RUN apt-get install -y mesa-utils mesa-utils-extra libxv1 

# set theme to avoid issue with missing spaces in menus.
RUN sed -i 's%<property name="ThemeName" type="string" value="Xfce"/>%<property name="ThemeName" type="string" value="Raleigh"/>%' /etc/xdg/xfce4/xfconf/xfce-perchannel-xml/xsettings.xml

# startscript to copy dotfiles from /etc/skel
# runs either CMD or image command from docker run
RUN echo '#! /bin/sh\n\
[ -n "$HOME" ] && [ ! -e "$HOME/.config" ] && cp -R /etc/skel/. $HOME/ \n\
unset DEBIAN_FRONTEND \n\
exec $*\n\
' > /usr/local/bin/start && chmod +x /usr/local/bin/start 

ENTRYPOINT ["/usr/local/bin/start"]
CMD ["startxfce4"]

ENV DEBIAN_FRONTEND newt
