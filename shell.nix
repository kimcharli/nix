{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    pyenv
    openssl
    xz
    zlib
    readline
    sqlite
    curl
    libiconv
    # nodejs_20
  ];

  shellHook = ''
    #export PATH="$PWD/node_modules/.bin:$PATH"
  '';
}