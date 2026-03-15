{ ... }:

{
  programs.kitty = {
    enable = true;
    package = null; # kitty installed via pacman, we only manage the config

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 15.0;
    };

    settings = {
      window_padding_width = 8;
      background_opacity = "0.85";
      background_blur = 20;
    };

    # Dragon Fire theme embedded directly
    extraConfig = builtins.readFile ../config/kitty/kanagawa-dragon.conf;
  };
}
