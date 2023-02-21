# Nix package for fw-ectool

This is a simple Nix package for the [Framework Laptop Embedded Controller project](https://github.com/FrameworkComputer/EmbeddedController). I'm currently using this on the 11th generation model with NixOS 22.11, though I've only tried using this to control the fanspeed on my device.

Please read the warnings on the original project page before using this. This can cause hardware damage to your device. 

---

To build this normally, clone this repository recursively with 

```sh
git clone --recurse-submodules git@github.com:ssddq/fw-ectool.git
``` 

You can then either run `nix-build`, or install it on NixOS by adding

```sh
(import path/to/fw-ectool/default.nix)
```

to your package list.

---

This can also be built as a flake, by either running:

```sh
nix build github:ssddq/fw-ectool
```

or cloning the repository and running

```sh
nix build path/to/clone
```

You do not need to clone recursively, as the `EmbeddedController` submodule will be downloaded while installing the flake.
