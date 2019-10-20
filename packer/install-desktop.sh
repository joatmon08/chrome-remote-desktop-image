#!/bin/bash -x
#
# Startup script to install Chrome remote desktop and a desktop environment.
#
# See environmental variables at then end of the script for configuration
#

set -o pipefail

function install_desktop_env {
  PACKAGES="desktop-base xscreensaver apt-transport-https libx11-xcb1 libxss1 libasound2 libxkbfile1"

  if [[ "$INSTALL_XFCE" != "yes" && "$INSTALL_CINNAMON" != "yes" ]] ; then
    # neither XFCE nor cinnamon specified; install both
    INSTALL_XFCE=yes
    INSTALL_CINNAMON=yes
  fi

  if [[ "$INSTALL_XFCE" = "yes" ]] ; then
    PACKAGES="$PACKAGES xfce4"
    echo "exec xfce4-session" > /etc/chrome-remote-desktop-session
    [[ "$INSTALL_FULL_DESKTOP" = "yes" ]] && \
      PACKAGES="$PACKAGES task-xfce-desktop"
  fi

  if [[ "$INSTALL_CINNAMON" = "yes" ]] ; then
    PACKAGES="$PACKAGES cinnamon-core"
    echo "exec cinnamon-session-cinnamon2d" > /etc/chrome-remote-desktop-session
    [[ "$INSTALL_FULL_DESKTOP" = "yes" ]] && \
      PACKAGES="$PACKAGES task-cinnamon-desktop"
  fi

  DEBIAN_FRONTEND=noninteractive \
    apt install --assume-yes $PACKAGES $EXTRA_PACKAGES

  systemctl disable lightdm.service
}

function download_and_install { # args URL FILENAME
  curl -L -o "$2" "$1"
  dpkg --install "$2"
  apt install --assume-yes --fix-broken
}

function is_installed {  # args PACKAGE_NAME
  dpkg-query --list "$1" | grep -q "^ii" 2>/dev/null
  return $?
}

# Configure the following environmental variables as required:
INSTALL_XFCE=yes
INSTALL_CINNAMON=yes
INSTALL_CHROME=yes
INSTALL_FULL_DESKTOP=yes

# Any additional packages that should be installed on startup can be added here
EXTRA_PACKAGES="less bzip2 zip unzip"

! is_installed chrome-remote-desktop && \
  download_and_install \
    https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb \
    /tmp/chrome-remote-desktop_current_amd64.deb

install_desktop_env

[[ "$INSTALL_CHROME" = "yes" ]] && \
  ! is_installed google-chrome-stable && \
  download_and_install \
    https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    /tmp/google-chrome-stable_current_amd64.deb

echo "Chrome remote desktop installation completed"