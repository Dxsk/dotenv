{ ... }:

{
  # Vim installed via pacman, we only manage the dotfiles
  # Assembled from files in vim/config/
  home.file.".vimrc".text = builtins.concatStringsSep "\n" [
    (builtins.readFile ../vim/config/apparence.vim)
    (builtins.readFile ../vim/config/scroll.vim)
    (builtins.readFile ../vim/config/cursor.vim)
    (builtins.readFile ../vim/config/statusline.vim)
    (builtins.readFile ../vim/config/settings.vim)
    (builtins.readFile ../vim/config/keybinds.vim)
  ];
  home.file.".vim/colors/kanagawa-dragon.vim".source = ../vim/colors/kanagawa-dragon.vim;
  home.file.".vim/undodir/.keep".text = "";
}
