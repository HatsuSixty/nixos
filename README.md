# NixOS

My NixOS configuration and dotfiles.

## How to install

*Actual installer coming soon*.  

For now, copy `./configuration.nix` to `/etc/nixos/configuration.nix`, and run the command:

```console
$ sudo nixos-rebuild switch
```

Then, set a password for the user `hatsu`, log in as that user, install [`home-manager`](https://github.com/nix-community/home-manager), and copy `./home-manager` to `~/.config/home-manager`. After that, you can run:

```
$ home-manager switch
```
