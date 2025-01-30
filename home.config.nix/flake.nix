{
  description = "Charlie nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, config, ... }: {
      # Enable unfree packages
      nixpkgs.config.allowUnfree = true;

      # Nix configuration
      nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
      };
      
      # Automatic store optimization
      nix.optimise.automatic = true;
      
      # Enable automatic garbage collection
      nix.gc = {
        automatic = true;
        interval = { Hour = 2; };  # Run at 2 AM
        options = "--delete-older-than 30d";
      };

      environment.systemPackages = with pkgs; 
        let
          # Python development environment
          pythonEnv = python311.withPackages (ps: with ps; [
            pip
            virtualenv
            pytest
            black
            flake8
            mypy
          ]);
        in
        [
          # Development Tools
          neovim
          git
          gh
          git-lfs
          ripgrep
          fd
          jq
          tree
          stow
          mkalias  # Required for application setup

          # Programming Languages & Runtimes
          pythonEnv
          nodejs_20  # LTS version
          lua
          rustup

          # Container & Cloud Tools
          colima
          docker
          docker-compose
          kubectl

          # Security & Network Tools
          nmap
          rustscan
          wireshark

          # System Utilities
          asciinema
          graphviz
          nix-tree
          ncurses
          openssl
          pkg-config

          # Build Dependencies
          readline
          sqlite
          xz
          zlib
          tcl

          # GUI Applications
          obsidian
          
          # AI/ML Tools
          ollama
        ];

      # Shell configuration
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableBashCompletion = true;
      };

      # Application management
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      # System configuration
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };

    darwinPackages = self.darwinConfigurations."mini".pkgs;
  };
}
