{
  description = "JavaScript development environment with node support";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShell.x86_64-linux = with pkgs;
      mkShell {
        buildInputs = [
          # Node.js and core tools
          nodejs_22
          # yarn
          nodePackages.npm
          # nodePackages.pnpm

          # Development tools
          nodePackages.typescript
          nodePackages.ts-node
          nodePackages.nodemon
          nodePackages.eslint
          nodePackages.prettier

          # Build tools
          nodePackages.node-gyp
          gcc
          gnumake

          # Version control
          # git

          # Additional useful tools
          jq # JSON processing
          curl # HTTP requests
          watchman # File watching
        ];

        shellHook = ''
          # Environment variables
          export PATH="$PWD/node_modules/.bin:$PATH"
          export NODE_ENV=development

          # NPM configuration
          npm config set prefix $PWD/.npm-global
          export PATH="$PWD/.npm-global/bin:$PATH"

          # Create .gitignore if it doesn't exist
          if [ ! -f .gitignore ]; then
            echo "node_modules/
            .npm-global/
            dist/
            .env
            .DS_Store
            *.log" > .gitignore
          fi

          # Print environment info
          echo "Node.js development environment loaded!"
          echo "Node version: $(node -v)"
          echo "NPM version: $(npm -v)"
        '';

        # Add common environment variables
        env = {
          # Add any project-specific environment variables here
        };
      };
  };
}
