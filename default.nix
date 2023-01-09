let
  pkgs = import <nixpkgs> { };
in 
pkgs.stdenv.mkDerivation {
  pname = "fw-ectool";
  name = "fw-ectool";

  src = ./.;

  dontFixup = true;
  
  buildInputs = [
    pkgs.pkg-config
    pkgs.libftdi1
    pkgs.libusb1
    pkgs.hostname
  ];

  configurePhase = ''
    cp -r $src/* .
    cd EmbeddedController
    bash util/getversion.sh > util/ec_version.h
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
