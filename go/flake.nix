{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    devShell.x86_64-linux = pkgs.mkShell {
      buildInputs = with pkgs; [
        # Go and core tools
        go
        gopls # Go language server
        go-tools # Additional Go tools like staticcheck
        delve # Go debugger

        # Additional development tools
        golangci-lint # Linter aggregator
        gotools # Contains tools like goimports
        gotests # Test boilerplate generator
        gore # Go REPL

        # Build tools
        gnumake
        gcc
      ];

      shellHook = ''
        # Set up GOPATH in the current directory
        export GOPATH="$PWD/.go"
        export PATH="$GOPATH/bin:$PATH"

        # Create necessary directories
        mkdir -p .go/bin .go/src .go/pkg

        echo "Go development environment ready!"
        echo "GOPATH set to: $GOPATH"
      '';
    };
  };
}
