## Dump

```shell
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > keybindings.conf
```

## Load

```shell
dconf load keybindings.conf /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
```
