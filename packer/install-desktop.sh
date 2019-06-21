#!/bin/bash -

echo "=== install Chrome Remote Desktop ==="

wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb

sudo apt update

sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install --assume-yes --fix-broken

echo "=== install xfce ==="

sudo DEBIAN_FRONTEND=noninteractive apt install --assume-yes xfce4 desktop-base

echo "xfce4-session" > ~/.chrome-remote-desktop-session

sudo apt install --assume-yes xscreensaver

echo "=== disable display ==="

sudo systemctl disable lightdm.service


echo "=== disable screensaver ==="
xset -dpms
xset s off
xset s noblank

echo "=== install Chrome ==="

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb

sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install --assume-yes --fix-broken