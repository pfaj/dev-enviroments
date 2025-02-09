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
        gpp
        clang
        clang-tools
        cmake
        gnumake
        ninja
        pkg-config
        gdb
        lldb
        valgrind
        boost
        fmt
        catch2
      ];
      shellHook = ''
        echo "C++ development environment ready!"
      '';
    };
  };
}
