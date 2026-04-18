{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/45b56b5321aed52d4464dc9af94dc1b20d477ac5.tar.gz") {} }:

pkgs.mkShell {
  buildInputs = [
    pkgs.emacs
    pkgs.gotty
    pkgs.tailscale
    pkgs.tmux
  ];

  shellHook = ''
    echo "=== Cloud Emacs environment ==="
  '';
}
