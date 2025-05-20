{
  description = "Java development environment with JDK and Maven/Gradle support";
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
          # Java Development Kit (JDK)
          jdk21 # You can choose a different JDK version like jdk17, jdk11, etc.

          # Build tools
          # maven # Apache Maven
          gradle # Gradle (uncomment if you prefer Gradle over Maven)


          # Additional useful tools
          jq 
          curl 
          # watchman # File watching (less common for Java, but can be kept if needed)
        ];

        shellHook = ''
          # Environment variables
          export JAVA_HOME=${jdk21} # Set JAVA_HOME to the chosen JDK
          export PATH="$JAVA_HOME/bin:$PATH"
          export MAVEN_OPTS="-Xmx1G -Djava.awt.headless=true" # Common Maven options

          # Print environment info
          echo "Java development environment loaded!"
          echo "Java version: $(java -version)"
          # echo "Maven version: $(mvn -v | head -n 1)"
          # Uncomment if using Gradle
          echo "Gradle version: $(gradle -v | head -n 1)"
        '';

        env = {
          # Add any project-specific environment variables here
          # Example: PROJECT_DATABASE_URL = "jdbc:postgresql://localhost/myproject";
        };
      };
  };
}
