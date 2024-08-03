{ config, pkgs, ... }:

{
  home.username = "hatsu";
  home.homeDirectory = "/home/hatsu";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  programs.git = {
    enable = true;
    userName  = "HatsuSixty";
    userEmail = "hatsunotsus@gmail.com";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      # Make autocomplete prettier
      zstyle ":completion:*" menu select
      zstyle ":completion:*" matcher-list "" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"

      # Shortcuts
      bindkey "^[[1;5D" backward-word
      bindkey "^[[1;5C" forward-word
      bindkey "^[[H" beginning-of-line
      bindkey "^[[F" end-of-line
      bindkey "^[[3~" delete-char
      bindkey "^[[3;5~" kill-word
      bindkey "^H" backward-kill-word
    '';

    shellAliases = {
      resystem = "sudo nixos-rebuild switch";
      rehome = "home-manager switch";
      cleanup = "sudo nix-store --gc";

      girlboss = "sudo !!";
      nano = "echo \"ERROR: could not open nano: normie editor detected\"";
      cls = "clear";
      vim = "nvim";
      md = "mkdir";
      demacs = "/bin/emacs";
      hiy = "git";
      last_installed = "command ls '--time-style=+%d %b %G %H:%M' -lct /etc | tail -1 | awk '{print $6, $7, $8, $9}'";
      wget = "wget -c";
      lf = "VISUAL=$EDITOR lf";
      neofetch = "hyfetch";

      ls = "eza --color=always -lah";
      l = "ls";

      grep = "grep --color=auto";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  home.packages = [
    pkgs.hello

    pkgs.neovim
    pkgs.font-awesome
    pkgs.emacs
    pkgs.nerdfonts
    pkgs.iosevka

    pkgs.clang
    pkgs.gnumake

    pkgs.alacritty
    pkgs.python3
    pkgs.tmux
    pkgs.brightnessctl

    pkgs.git
    pkgs.zsh
    pkgs.wget
    pkgs.unzip
    pkgs.stow
    pkgs.eza

    pkgs.discord
    pkgs.lutris

    # Terminal "script"
    (pkgs.writeCBin "terminal" (builtins.readFile "${./terminal.c}"))

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  ];

  # Home files
  home.file = {
    ".hello".text = "hii welcome :3";

    ".tmux.conf".text = ''
      ## Keybindings

      # Prefix

      unbind C-b
      set -g prefix C-x
      bind C-x send-prefix

      # Emacs style keys

      set -g mode-keys emacs
      set -g status-keys emacs
      set -s escape-time 0

      # Switch between panes

      bind -n S-left prev
      bind -n S-right next

      ## Fix terminal colors

      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      ## Status bar colors

      set -g status-bg color237
      set -g status-fg color255
    '';

    ".config/emacs" = {
      source = ./emacs;
      recursive = true;
    };

    ".config/alacritty" = {
      source = ./alacritty;
      recursive = true;
    };

    ".config/nvim" = {
      source = ./nvim;
      recursive = true;
    };
  };

  # Desktop entries
  xdg.desktopEntries = {
    terminal = {
      name = "Terminal";
      categories = ["Application" "System" "TerminalEmulator"];
      terminal = false;
      exec = "terminal %U";
      icon = "utilities-terminal";
    };
  };

  # Environment variables
  home.sessionVariables = {
    CUTIE = "YOU!";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
