# Quick start

## Install (Nix)

```shell
nix develop
```

The `quick-start` directory is known as the Zephyr workspace.

## Setup

First, we need to setup the Zephyr environment using the manifest in the application.

```shell
west init -l app
```

This will tell west where to install Zephyr sources and modules.

Then, install them all:

```shell
cd app
west update
```
This will install Zephyr sources and modules at the parent directory of the application in `app` as
specified in the `app/west.yml` manifest.

## Build the application

At the root of the Zephyr workspace:

```shell
just build
```
This will build the applicaiton in `app` for the default board specified in `Justfile`.
