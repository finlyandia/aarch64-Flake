{
  imports = [
    ../modules/hardware/default.nix
    ../modules/user/default.nix
    ../modules/ssh/default.nix
    ../modules/hydra/default.nix
    ../modules/postgresql/default.nix
  ];
  module = {
    hardware.enable = true;
    user.enable = true;
    ssh.enable = true;
    hydra.enable = true;
    postgresql.enable = true;
  };
}
