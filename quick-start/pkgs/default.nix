{ inputs, pkgs, ... }:

{
  openocd-cubeide = pkgs.callPackage ./openocd-cubeide { };
}
