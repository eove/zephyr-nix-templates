{
  description = "Nix templates for Zephyr development";

  outputs = { self }:
  {
    templates = {
      quick-start = {
        path = ./quick-start;
        description = "A basic quick start";
      };
    };
  };
}
