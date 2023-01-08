# Nix package for fw-ectool

This is a simple Nix package for the [Framework Laptop Embedded Controller project](https://github.com/FrameworkComputer/EmbeddedController). I'm currently using this on the 11th generation model with NixOS 22.11, though I've only tried using this to control the fanspeed on my device.

Please read the warnings on the original project page before using this. This can cause hardware damage to your device. 

Make sure to clone with `git clone --recurse-submodules`. You can build this with `nix-build`, or install it on NixOS by adding

```sh
(import path/to/fw-ectool/default.nix)
```

to your package list.
