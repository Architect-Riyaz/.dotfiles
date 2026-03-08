{
  description = "My dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    systems = {
      wsl = "x86_64-linux";
      debian = "x86_64-linux";
      mac = "aarch64-darwin";
    };
  in
  {
    homeConfigurations = {
      wsl = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = systems.wsl; };

        modules = [
          ./home/common.nix
          ./home/user.nix
          ./home/wsl.nix
        ];

        # pass username at runtime
        extraSpecialArgs = {
          system = systems.wsl;
        };
      };

      debian = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = systems.debian; };
        modules = [
          ./home/common.nix
          ./home/user.nix
          ./home/debian.nix
        ];

        extraSpecialArgs = {
          system = systems.debian;
        };
      };

      mac = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = systems.mac; };
        modules = [
          ./home/common.nix
          ./home/user.nix
          ./home/mac.nix
        ];

        extraSpecialArgs = {
          system = systems.mac;
        };
      };
    };
  };
}
