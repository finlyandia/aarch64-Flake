{
  imports = [
    ../modules/hardware/default.nix
    ../modules/user/default.nix
    ../modules/ssh/default.nix
    ../modules/postgresql/default.nix
    ../modules/bypass/default.nix
    ../modules/gitea/default.nix
  ];
  module = {
    hardware.enable = true;
    user.enable = true;
    ssh.enable = true;
    postgresql.enable = true;
    bypass.enable = true;
    gitea.enable = true;
  };
}
