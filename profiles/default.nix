{
  imports = [
    ../modules/hardware/default.nix
    ../modules/user/default.nix
    ../modules/ssh/default.nix
    ../modules/postgresql/default.nix
    ../modules/bypass/default.nix
    ../modules/gitea/default.nix
    ../modules/shadowsocks/default.nix
  ];
  module = {
    hardware.enable = true;
    user.enable = true;
    ssh.enable = true;
    postgresql.enable = false;
    bypass.enable = true;
    gitea.enable = false;
    shadowsocks.enable = true;
  };
}
