{ pkgs ? import <nixpkgs> {} }:

let
  libs = pkgs.lib.makeLibraryPath (with pkgs; [ stdenv.cc.cc.lib glib libGL ]);
in pkgs.mkShell {
  name = "TLNet";

  venvDir = "./.venv";

  buildInputs = with pkgs; [
    python39
    python39Packages.pip
    python39Packages.setuptools
    python3Packages.tensorflow-tensorboard
    python3Packages.tensorboardx
    python3Packages.tensorboard-data-server

    python39Packages.venvShellHook
  ];

  postShellHook = ''
    export LD_LIBRARY_PATH=${libs}:$LD_LIBRARY_PATH
  '';
}
