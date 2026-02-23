{
  description = "Riyaz reproducible environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }:
  let
    mkHome = system: modules:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { inherit system; };
        modules = modules;
      };
  in {
    homeConfigurations = {
      wsl = mkHome "x86_64-linux" [
        ./home/common.nix
        ./home/wsl.nix
      ];

      debian = mkHome "x86_64-linux" [
        ./home/common.nix
        ./home/debian.nix
      ];

      mac = mkHome "aarch64-darwin" [
        ./home/common.nix
        ./home/mac.nix
      ];
    };
  };
}
