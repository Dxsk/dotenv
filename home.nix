{ config, pkgs, username, homeDir, ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/vim.nix
    ./modules/zsh.nix
    ./modules/kitty.nix
    ./modules/hyprland.nix
    ./modules/gtk.nix
    ./modules/qt.nix
    ./modules/backup.nix
    ./modules/desktop-entries.nix
  ];

  home = {
    username = username;
    homeDirectory = homeDir;
    stateVersion = "24.11";
  };

  # Config files managed directly (no dedicated HM module)
  xdg.configFile = {
    # Fastfetch
    "fastfetch/config.jsonc".source = ./config/fastfetch/config.jsonc;

    # Ambxst (bar)
    "ambxst/colors/Dragon Fire/dark.json".source = ./config/ambxst/colors/Dragon_Fire/dark.json;
    "ambxst/colors/Dragon Fire/light.json".source = ./config/ambxst/colors/Dragon_Fire/light.json;

    # Kvantum
    "Kvantum/kvantum.kvconfig".source = ./config/Kvantum/kvantum.kvconfig;

    # KDE globals
    "kdeglobals".source = ./config/kdeglobals;

    # VSCodium
    "VSCodium/User/settings.json".source = ./config/VSCodium/User/settings.json;

    # Vesktop (Discord) - flags Wayland + screen sharing PipeWire
    "vesktop-flags.conf".source = ./config/vesktop-flags.conf;
  };

  programs.home-manager.enable = true;
}
