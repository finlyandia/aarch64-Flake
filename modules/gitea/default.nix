{
  lib,
  config,
  settings,
  ...
}: let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.gitea;

in {
  options.module.gitea.enable = mkEnableOption "";
  config = mkIf cfg.enable {
    services = {
      gitea = {
        enable = true;
        user = "gitea";
        group = "gitea";
        appName = "Gitea Service";
        settings = {
          server = {
            DOMAIN = "0.0.0.0";
            HTTP_PORT = 3030;
          };
        };
        database = {
          user = "gitea";
          type = "postgres";
        };
      };
    };
  };
}
