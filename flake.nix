{
  description = "Nix templates for Zephyr development";

  outputs = {
    templates = {
      quick-start = {
        path = ./quick-start;
        description = "A basic quick start";
      };
    };
  };
}
