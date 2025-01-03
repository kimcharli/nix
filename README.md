# nix

https://nix.dev/manual/nix/2.18/introduction
https://zero-to-nix.com/
https://wiki.nixos.org/wiki/NixOS_Wiki
https://nix.dev/manual/nix/2.18/command-ref/new-cli/nix3-flake#flake-format
https://github.com/NixOS/nixpkgs
https://search.nixos.org/packages


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

# uninstall

https://nix.dev/manual/nix/2.24/installation/uninstall.html#macos






