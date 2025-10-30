{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.hydra;

in {
  options.module.hydra.enable = mkEnableOption "";
  config = mkIf cfg.enable {
    services.hydra = {
      enable = true;
      package = inputs.hydra.packages.${pkgs.stdenv.hostPlatform.system}.hydra;
      dbi = "dbi:Pg:dbname=hydra;user=hydra;";
      gcRootsDir = "/nix/var/nix/gcroots/hydra";
      port = 5555;
      listenHost = "0.0.0.0";
      hydraURL = "http://hydra.main.com";
      useSubstitutes = true;
      notificationSender = "http://hydra.main.com";
      buildMachinesFiles = [ ];
    };
    nix = {
      distributedBuilds = true;
      extraOptions = ''
        builders-use-substitutes = true
      '';
      buildMachines = [
        {
          hostName = "192.168.1.150";
          system = "x86_64-linux";
          sshUser = "nix";
          sshKey = "/etc/nix/ssh/builder_ed25519";
          maxJobs = 4;
          supportedFeatures = [ "kvm" "nixos-test" "big-parallel" ];
          mandatoryFeatures = [ ];
        }
      ];
    };
    systemd.services.hydra-setup = {
      serviceConfig.Type = "oneshot";
      script = ''
        if [ ! -f /etc/nix/ssh/builder_ed25519 ]; then
        mkdir -p /etc/nix/ssh
        ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f /etc/nix/ssh/builder_ed25519 -N "" -C "hydra-builder"
        fi
      '';
      wantedBy = ["multi-user.target"];
    };
  };
}
