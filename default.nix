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
  '';
}
