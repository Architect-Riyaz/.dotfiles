{
  description = "My dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux"; # change on mac if needed
    pkgs = import nixpkgs { inherit system; };
  in
  {
    homeConfigurations = {
      wsl = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./home/common.nix
          ./home/user.nix
          ./home/wsl.nix
        ];

        # pass username at runtime
        extraSpecialArgs = {
          inherit system;
        };
      };

      debian = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/common.nix
          ./home/user.nix
          ./home/debian.nix
        ];
      };

      mac = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home/common.nix
          ./home/user.nix
          ./home/mac.nix
        ];
      };
    };
  };
}
