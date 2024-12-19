# Nix Flake Dev Enviroments

Aimed to streamline direnvs (directory enviroments) which can be used on a project by project basis so
that you can declare all dependicies for each project and never have conflicts with other projects.

1. Clone this repository
   - `https://github.com/pfaj/dev-enviroments`
2. Go to project folder that you want to make a directory enviroment
    - `cd path/to/project`
3. run `nix flake init -t path/to/repo#language`

This should allow you to use these templates and be able to replicate them in any project you may need
