{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    rust-overlay,
  }: let
    system = "x86_64-linux";
    overlays = [(import rust-overlay)];
    pkgs = import nixpkgs {
      inherit system;
      inherit overlays;
    };
  in {
    devShell.x86_64-linux = pkgs.mkShell {
      buildInputs = with pkgs; [
        rustc
        rustup
        rust-bin.stable.latest.default
        pkg-config
        openssl
      ];

      shellHook = ''
        # Add cargo bin to PATH
        export PATH="$HOME/.cargo/bin:$PATH"
      '';
    };
  };
}
