{
  description = "Flake for generating project templates";

  outputs = {self}: {
    templates = {
      blank = {
        path = ./blank;
        description = "Blank flake for custom enviroments";
      };
      c = {
        path = ./c;
        description = "C development enviroment";
      };
      cpp = {
        path = ./cpp;
        description = "C++ development enviroment";
      };
      go = {
        path = ./go;
        description = "Go development environment";
      };
      js = {
        path = ./js;
        description = "Node.js development environment with TypeScript and ESLint";
      };
      java = {
        path = ./java;
        description = "Java development environment";
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
