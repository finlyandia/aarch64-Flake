{

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    }; 

    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hydra = {
      url = "github:NixOS/hydra";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { 
    self, 
    hydra,
    nixpkgs, 
    nixos-hardware
  }@inputs: 

  {
    nixosConfigurations = {
      rpi4 = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./profiles/default.nix
          nixos-hardware.nixosModules.raspberry-pi-4
        ];
      };
    };
  };

}
