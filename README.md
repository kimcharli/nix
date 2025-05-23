# Nix Development Environment

This repository contains my personal Nix configuration for macOS, providing a reproducible and declarative development environment. It uses `nix-darwin` to manage system configuration and packages.

## Purpose

- Maintain a consistent development environment across machines
- Automate system maintenance and package management
- Ensure reproducible builds and development setups
- Keep system dependencies clean and organized

## Features

- **Automated Maintenance**:
  - Daily garbage collection at 2 AM
  - Automatic store optimization
  - Clean system state management

- **Development Tools**:
  - Modern text editor (Neovim)
  - Version control (Git, GitHub CLI)
  - Search utilities (ripgrep, fd)
  - Container tools (Docker, Colima)

- **Programming Environments**:
  - Python (with testing and linting tools)
  - Node.js LTS
  - Rust
  - Lua

- **System Utilities**:
  - Network tools (nmap, wireshark)
  - System monitoring
  - Package management

## Daily Activities

### System Maintenance
- Check system updates: `darwin-rebuild build --flake .#mini`
- Apply updates: `darwin-rebuild switch --flake .#mini`
- Manual garbage collection if needed: `nix-collect-garbage -d`

### Development Workflow
1. Start development containers: `colima start`
2. Check Docker status: `docker ps`
3. Update development tools: `darwin-rebuild switch --flake .#mini`

### Troubleshooting
- View system configuration: `darwin-rebuild show-config`
- Check Nix store: `nix store verify`
- View garbage collector status: `launchctl list | grep nix-gc`

## Installation

1. Install Nix:
```bash
sudo sh <(curl -L https://nixos.org/nix/install)
```

2. Enable flakes in `~/.config/nix/nix.conf`:
```
experimental-features = nix-command flakes
```

3. Initial setup:
```bash
mkdir ~/.config/nix
cd ~/.config/nix
nix flake init -t nix-darwin
```

4. Apply configuration:
```bash
darwin-rebuild switch --flake .#mini
```

## Useful Resources

- [Nix Manual](https://nix.dev/manual/nix/2.18/introduction)
- [Zero to Nix](https://zero-to-nix.com/)
- [NixOS Wiki](https://wiki.nixos.org/wiki/NixOS_Wiki)
- [Nix Packages Search](https://search.nixos.org/packages)
- [nixpkgs Repository](https://github.com/NixOS/nixpkgs)

## Maintenance Notes

- Garbage collection runs automatically at 2 AM
- System optimization runs automatically
- Configuration changes should be committed to Git
- Test changes with `darwin-rebuild build` before applying

# installation

https://nixos.org/download/
```
sudo sh <(curl -L https://nixos.org/nix/install)
```

```
nix-shell -p nix-info --run "nix-info -m"
```

dry run
```
nix-shell -p neofetch --run neofetch
```

first time config
```
mkdir ~/.config/nix
cd ~/.config/nix
nix flake init -t nix-darwin --extra-experimental-features "nix-command flakes"

EDIT

nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix#mini
```

## enable flakes in default config

~/.config/nix/nix.conf 
```
experimental-features = nix-command flakes
```


on new shell
```
which darwin-rebuild
```


# update package

edit ~/.config/nix/flake.nix 
```
      environment.systemPackages =
        [ pkgs.vim
          pkgs.colima
        ];
```

```
darwin-rebuild switch --flake ~/.config/nix#mini
```

# misc

search package
https://search.nixos.org/packages
or
```
nix search nixpkgs tmux
```

```
nix-env -qaP | grep openssl
```


Availabe packages -- very long

```
nix-env --query --available --attr-path
```


# Application

## colima

```
nix-shell -p colima
```

## garbage

```
nix-collect-garbage -d
```

# recover

```
nix-shell -p git --run 'git clone https://github.com/kimcharli/nix.git .dotfiles'

nix run nix-darwin --extra-experimental-features 'nix-command flakes' -- switch --flake ~/sotfiles/nix/darwin#mac-mini

```

# update

```
sudo nix-channel --update
```

# uninstall

https://nix.dev/manual/nix/2.24/installation/uninstall.html#macos

# misc

## nvm, node, claude code

https://nodejs.org/en/download

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install node
nvm install --lts

npm install @anthropic-ai/claude-code
```
