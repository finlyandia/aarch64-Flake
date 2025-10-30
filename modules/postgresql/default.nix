{
  lib,
  config,
  settings,
  ...
}: let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.postgresql;

in {
  options.module.postgresql.enable = mkEnableOption "";
  config = mkIf cfg.enable {
    services = {
      postgresql = {
        enable = true;
      };
    };
  };
}
