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

    # VSCodium settings.json is copied via activation script below
    # so VSCodium can write to it (symlinks are read-only)

    # Vesktop (Discord) - flags Wayland + screen sharing PipeWire
    "vesktop-flags.conf".source = ./config/vesktop-flags.conf;
  };

  # Copy VSCodium settings as a regular file so it remains writable
  home.activation.vscodiumSettings = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    install -Dm644 ${./config/VSCodium/User/settings.json} \
      "${config.xdg.configHome}/VSCodium/User/settings.json"
  '';

  programs.home-manager.enable = true;
}
