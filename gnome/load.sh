#!/bin/bash

dconf load /org/gnome/shell/extensions/ < gnome-extensions.conf
dconf load /org/gnome/shell/keybindings/ < gnome-keybindings.conf
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > gnome-custom-keybindings.conf
