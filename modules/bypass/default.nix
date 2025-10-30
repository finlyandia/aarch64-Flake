{
  lib,
  pkgs,
  config,
  ...
}: let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.bypass;

in {
  options.module.bypass.enable = mkEnableOption "";
  config = mkIf cfg.enable {
    services.zapret = {
      enable = true;
      qnum = 0;
      params = [
        "--dpi-desync=disorder"
        "--dpi-desync-ttl=1"
        "--dpi-desync-any-protocol=1"
      ];
      udpSupport = true;
      udpPorts = [ "443" ];
      httpSupport = false;
      configureFirewall = false;
    };
  };
}
