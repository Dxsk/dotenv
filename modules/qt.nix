{ ... }:

{
  # Qt6ct config
  xdg.configFile."qt6ct/qt6ct.conf".source = ../config/qt6ct/qt6ct.conf;

  # Variables d'environnement Qt
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}
