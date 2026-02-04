{
  description = "NixOS configuration with NVIDIA RTX 4060 and Ollama";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixos-rebuild
            git
          ];
        };
      }
    ) // {
      nixosConfigurations.nvgs1 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware.nix
          ./configuration.nix
        ];
      };
    };
}
