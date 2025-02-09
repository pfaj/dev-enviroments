{
  description = "Flake for generating project templates";

  outputs = {self}: {
    templates = {
      blank = {
        path = ./blank;
        description = "Blank flake for custom enviroments";
      };
      go = {
        path = ./go;
        description = "Go development environment";
      };
      js = {
        path = ./js;
        description = "Node.js development environment with TypeScript and ESLint";
      };
      python = {
        path = ./python;
        description = "Python development environment with comprehensive tooling";
      };
      rust = {
        path = ./rust;
        description = "Rust development environment with comprehensive tooling";
      };
    };
  };
}
