# Nix templates for Zephyr projects

This repository contains templates for new Zephyr projects and applications.

## Quick start

This is a very minimal template that setup a Zephyr development environment for C projects.

```shell
nix flake new --template github:eove/zephyr-nix-templates#quick-start my-new-project
```
or if your already have an empty directory:

```shell
nix flake init --template github:eove/zephyr-nix-templates#quick-start
```
