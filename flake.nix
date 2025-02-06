{
  description = "Nix templates for Zephyr development";

  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      flake-utils,
      nixpkgs-unstable,
    }:
    {
      templates = {
        quick-start = {
          path = ./quick-start;
          description = "A basic quick start";
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs-unstable { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            statix
          ];
        };
      }
    );
}
