{ pkgs ? import <nixpkgs> {} , ecpath ? "./EmbeddedController" }:

pkgs.stdenv.mkDerivation {
  pname   = "fw-ectool";
  version = "0.0.16715";

  src = ./.;

  ecpath = ecpath;

  buildInputs = [
    pkgs.pkg-config
    pkgs.libftdi1
    pkgs.libusb1
    pkgs.hostname
  ];

  configurePhase = ''
    # Flakes do not normally copy submodules when building.
    # As a workaround, the submodule needs to be copied from
    # the path passed to the derivation from the flake.
    # The local copy of the submodule is used if the submodule is present,
    # checked by the presence of the README.md file;
    # otherwise, nix build uses a copy of the Github repository
    # that was downloaded to the store.

    if [ ! -f "./EmbeddedController/README.md" ]
    then
      mkdir -p ./EmbeddedController
      mkdir -p ./EmbeddedController/util
      cp -r $ecpath/* ./EmbeddedController
    fi
    cd ./EmbeddedController
    patchShebangs ./util/getversion.sh
    bash ./util/getversion.sh > ./util/ec_version.h
  '';

  buildPhase = ''
    make utils
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv $out/util/ectool $out/bin
    # cleanup for build artifacts
    rm -r $out/gen
    rm -r $out/libsharedobjs
    rm -r $out/RO
    rm -r $out/RW
    rm -r $out/util
  '';
}
