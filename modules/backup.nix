{ config, pkgs, lib, ... }:

let
  excludeFile = pkgs.writeText "restic-excludes" ''
    .cache
    .local/share/Trash
    .local/share/Steam
    .mozilla/firefox/*/cache2
    .config/VSCodium/CachedData
    .config/VSCodium/CachedExtensionVSIXs
    .cargo/registry
    .rustup/toolchains
    .npm/_cacache
    node_modules
    __pycache__
    .venv
    *.pyc
    .thumbnails
    .nix-defexpr
    .nix-profile
    Downloads/iso
    Downloads/*.iso
    .local/share/baloo
    .exegol
    .docker
    .local/share/containers
    .local/share/docker
  '';

  backupScript = pkgs.runCommand "home-backup" { } ''
    mkdir -p $out/bin
    substitute ${../scripts/home-backup.sh} $out/bin/home-backup \
      --replace-fail "@notify_send@" "${pkgs.libnotify}/bin/notify-send" \
      --replace-fail "@exclude_file@" "${excludeFile}"
    chmod +x $out/bin/home-backup
  '';

in
{
  home.packages = [
    pkgs.restic
    pkgs.rclone
    backupScript
  ];

  # Service systemd pour le backup automatique
  systemd.user.services.home-backup = {
    Unit = {
      Description = "Restic backup du home vers kDrive WebDAV";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${backupScript}/bin/home-backup backup";
      Nice = 10;
      IOSchedulingClass = "idle";
    };
  };

  # Service pour le nettoyage des anciens snapshots
  systemd.user.services.home-backup-prune = {
    Unit = {
      Description = "Restic prune des anciens snapshots";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${backupScript}/bin/home-backup prune";
      Nice = 19;
      IOSchedulingClass = "idle";
    };
  };

  # Timer : prune hebdomadaire (dimanche)
  systemd.user.timers.home-backup-prune = {
    Unit = {
      Description = "Timer hebdomadaire pour nettoyage des snapshots";
    };
    Timer = {
      OnCalendar = "weekly";
      Persistent = true;
      RandomizedDelaySec = "1h";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  # Service pour la verification d'integrite
  systemd.user.services.home-backup-check = {
    Unit = {
      Description = "Restic verification d'integrite du depot";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${backupScript}/bin/home-backup check";
      Nice = 19;
      IOSchedulingClass = "idle";
    };
  };

  # Timer : check mensuel (1er du mois)
  systemd.user.timers.home-backup-check = {
    Unit = {
      Description = "Timer mensuel pour verification d'integrite";
    };
    Timer = {
      OnCalendar = "monthly";
      Persistent = true;
      RandomizedDelaySec = "2h";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };

  # Timer : backup quotidien
  systemd.user.timers.home-backup = {
    Unit = {
      Description = "Timer pour backup quotidien du home";
    };
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "30min";
    };
    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
