{
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    zephyr-nix = {
      url = "github:adisbladis/zephyr-nix";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        zephyr.follows = "zephyr-src";
      };
    };

    zephyr-src = {
      url = "github:zephyrproject-rtos/zephyr/v4.0.0";
      flake = false;
    };
  };

  outputs = { nixpkgs-unstable, flake-utils, zephyr-nix, zephyr-src, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [
          (final: _: import ./pkgs { inherit (final) pkgs; inherit inputs; })
        ];

        pkgs = import nixpkgs-unstable { inherit overlays system; };
        zephyr-nix' = zephyr-nix.packages.${system};

        zephyr-sdk = zephyr-nix'.sdk.override {
          targets = [ "arm-zephyr-eabi" ];
        };
      in
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              # Load the python environment for Zephyr.
              # zephyr-nix'.pythonEnv

              # Install python and west from nix.
              python312
              python312Packages.west
              python312Packages.pyelftools

              # Zephyr SDK.
              zephyr-sdk

              # Build dependencies.
              dtc
              cmake
              ninja
              pkg-config

              # Utilities.
              eza
              fd
              just
              ripgrep

              # Probes.
              probe-rs-tools
            ];
            
            LIBCLANG_PATH = "${pkgs.llvmPackages_17.libclang.lib}/lib";

            shellHook = ''
              # Install aliases.
              alias ll="eza -l --git --icons"
              alias la="eza -l -a --git --icons"
              alias find=fd
            '';
          };
        }
    );
}
