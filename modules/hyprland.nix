{ ... }:

{
  # Hyprland installed via pacman (CachyOS), we only manage configs
  xdg.configFile = {
    "hypr/hyprland.conf".source = ../config/hypr/hyprland.conf;
    "hypr/monitors.conf".source = ../config/hypr/monitors.conf;
    "hypr/hyprqt6engine.conf".source = ../config/hypr/hyprqt6engine.conf;
    "hypr/workspaces.conf".source = ../config/hypr/workspaces.conf;
    "hypr/hypridle.conf".source = ../config/hypr/hypridle.conf;
  };
}
