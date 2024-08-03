# NixOS

My NixOS configuration and dotfiles.

## How to install

*Actual installer coming soon*.  

For now, make sure you have [`home-manager`](https://github.com/nix-community/home-manager) installed, and copy `./home-manager` to `~/.config/home-manager`, and `./configuration.nix` to `/etc/nixos/configuration.nix`. Then run the following commands:

```
$ sudo nixos-rebuild switch
$ home-manager switch
```
