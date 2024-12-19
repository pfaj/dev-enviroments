{
  description = "Development environment templates for Python and Node.js";

  outputs = {self}: {
    templates = {
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
