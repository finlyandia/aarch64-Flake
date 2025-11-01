{
  lib,
  config,
  ...
}: let

  inherit (lib) mkEnableOption mkIf;
  cfg = config.module.shadowsocks;

in {
  options.module.shadowsocks.enable = mkEnableOption "";
  config = mkIf cfg.enable {
    services.shadowsocks = {
      enable = true;
      port = 8388;
      password = "1337";
      encryptionMethod = "aes-128-gcm"; 
      localAddress = "0.0.0.0";
    };
  };
}
