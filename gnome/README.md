## Dump

```shell
dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > keybindings.conf
```

## Load

```shell
cat keybindings.conf | dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
```
