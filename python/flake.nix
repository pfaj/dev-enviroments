{
  description = "Python development environment with pip support";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};

        # Explicitly specify Python 3.11
        python = pkgs.python311;

        # Python environment with pip using Python 3.11
        pythonEnv = python.withPackages (ps:
          with ps; [
            pip
            setuptools
            wheel
            virtualenv
            numpy
          ]);
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            pythonEnv
            gcc
            gnumake
            # Add dependencies that onnxruntime might need
            cmake
            pkg-config
            openssl
            libffi
            zlib
          ];

          shellHook = ''
            # Ensure we're using Python 3.11
            if [[ $(${python}/bin/python --version) != *"3.11"* ]]; then
              echo "Error: Wrong Python version detected"
              exit 1
            fi

            # Remove existing venv if wrong Python version
            if [ -d .venv ] && [[ $(${pythonEnv}/bin/python --version) != *"3.11"* ]]; then
              echo "Removing existing virtual environment with wrong Python version..."
              rm -rf .venv
            fi

            # Create a virtual environment if it doesn't exist
            if [ ! -d .venv ]; then
              echo "Creating virtual environment..."
              ${pythonEnv}/bin/python -m venv .venv
            fi

            # Activate the virtual environment
            source .venv/bin/activate

            # Make sure pip is up to date
            pip install --upgrade pip

            # Set environment variables for onnxruntime
            export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
            export PYTHONPATH="$PYTHONPATH:$(pwd)/.venv/lib/python*/site-packages"

            # Set additional environment variables that might be needed
            export CMAKE_PREFIX_PATH=${pkgs.cmake}/share/cmake
            export PKG_CONFIG_PATH="${pkgs.openssl.dev}/lib/pkgconfig"

            echo "Python development environment ready!"
            echo "Virtual environment has been activated."
            echo "You can now use pip to install packages."
            python --version
          '';
        };
      }
    );
}
