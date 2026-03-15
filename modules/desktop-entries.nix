{ pkgs, ... }:

{
  # Override zen.desktop to add --no-remote (independent windows)
  home.activation.checkZenBrowser = ''
    if ! command -v zen-browser &>/dev/null; then
      echo "⚠ zen-browser not found. Install with: yay -S zen-browser-bin"
    fi
  '';

  xdg.desktopEntries.zen = {
    name = "Zen Browser";
    comment = "Experience tranquillity while browsing the web without people tracking you!";
    exec = "/opt/zen-browser-bin/zen-bin --no-remote %u";
    icon = "zen-browser";
    type = "Application";
    categories = [ "Network" "WebBrowser" ];
    startupNotify = true;
    terminal = false;
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
      "application/x-xpinstall"
      "application/pdf"
      "application/json"
    ];
    settings = {
      StartupWMClass = "zen";
      Keywords = "Internet;WWW;Browser;Web;Explorer;";
    };
    actions = {
      new-window = {
        name = "Open a New Window";
        exec = "/opt/zen-browser-bin/zen-bin --no-remote %u";
      };
      new-private-window = {
        name = "Open a New Private Window";
        exec = "/opt/zen-browser-bin/zen-bin --no-remote --private-window %u";
      };
      profilemanager = {
        name = "Open the Profile Manager";
        exec = "/opt/zen-browser-bin/zen-bin --ProfileManager %u";
      };
    };
  };
}
