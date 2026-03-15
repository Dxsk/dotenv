{ pkgs, lib, inputs, system, ... }:

let
  # Packages that must be installed via pacman (D-Bus, system services, etc.)
  requiredPacmanPackages = [
    "xdg-desktop-portal-gtk"
    "rocketchat-desktop"
    "bws-bin"
  ];
in
{
  home.packages = (with pkgs; [
    # Bluetooth
    blueman
    bluetuith
  ]) ++ [
    inputs.git-identity-manager.packages.${system}.default
  ];

  # Check that pacman/AUR dependencies are present
  home.activation.checkPacmanDeps = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    missing=""
    for pkg in ${lib.concatStringsSep " " requiredPacmanPackages}; do
      if ! pacman -Qi "$pkg" &>/dev/null; then
        missing="$missing $pkg"
      fi
    done
    if [ -n "$missing" ]; then
      echo ""
      echo "⚠ Missing pacman/AUR packages:$missing"
      echo "  Install with: yay -S$missing"
      echo ""
    fi
  '';
}
