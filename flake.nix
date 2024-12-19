{
  description = "Flake for generating project templates";

  outputs = {self}: {
    templates = {
      blank = {
        path = ./blank;
        description = "Blank flake for custom tooling";
      };
      python = {
        path = ./python;
        description = "Python development environment with comprehensive tooling";
      };
      nodejs = {
        path = ./nodejs;
        description = "Node.js development environment with TypeScript and ESLint";
      };
      rust = {
        path = ./rust;
        description = "Rust development environment with comprehensive tooling";
      };
    };
  };
}
