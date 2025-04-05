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
        gcc
        gnumake
        cmake
        pkg-config
        gdb
        valgrind
      ];
      shellHook = ''
        echo "C development environment ready!"
      '';
    };
  };
}
