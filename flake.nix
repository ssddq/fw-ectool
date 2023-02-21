{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    ec-local = {
      url = "git+file:./EmbeddedController";
      flake = false;
    };
    ec-git = {
      url = "git+https://github.com/FrameworkComputer/EmbeddedController";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ec-local, ec-git }:
  let
    ecpath = if (builtins.pathExists (self.outPath + "/EmbeddedController/README.md"))
             then
               ec-local.outPath
             else
               ec-git.outPath;
  in
  {
    packages.x86_64-linux.default = import ./default.nix 
      { pkgs = nixpkgs.legacyPackages.x86_64-linux; ecpath = ecpath; };
  };
}
