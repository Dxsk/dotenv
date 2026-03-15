{ pkgs, ... }:

{
  # Zsh installed via pacman, we only manage .zshrc
  # Assembled from files in zsh/
  home.file.".zshrc".text = builtins.concatStringsSep "\n" [
    (builtins.readFile ../zsh/prompt.zsh)
    (builtins.readFile ../zsh/plugins.zsh)
    (builtins.readFile ../zsh/init.zsh)
    (builtins.readFile ../zsh/aliases.zsh)
    (builtins.readFile ../zsh/sourceme.zsh)
  ];
}
