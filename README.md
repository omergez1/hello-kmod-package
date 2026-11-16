# hello-kmod-package

Hello-world Linux kernel module for the Raspberry Pi 5, packaged to be built by Buildroot as a kernel-module package.

The module prints `hello world` when loaded and `bye bye world` when unloaded.

## Layout

```
hello-kmod-package/
├── src/                     ← module source: what Buildroot downloads and compiles
│   ├── hello_kmod.c
│   └── Makefile             (Kbuild: obj-m := hello_kmod.o)
└── package/hello-kmod/      ← the Buildroot package: copy into Buildroot's package/
    ├── Config.in            (menuconfig entry BR2_PACKAGE_HELLO_KMOD)
    ├── hello-kmod.mk        (version, download site, kernel-module build)
    └── hello-kmod.hash      (sha256 of the downloaded tarball)
```

A Buildroot package does not contain source code. It describes where to download the source, how to verify it and how to build it. Buildroot downloads this repository at tag `v1.0` from GitHub, verifies it against `hello-kmod.hash`, and builds `src/` against the target kernel (`HELLO_KMOD_MODULE_SUBDIRS = src`).

## Adding the package to Buildroot

1. Copy the package directory:
   ```bash
   cp -r package/hello-kmod <buildroot>/package/
   ```
2. Reference it in `<buildroot>/package/Config.in`, in the **Hardware handling** menu:
   ```
   source "package/hello-kmod/Config.in"
   ```
3. Enable it (requires a Linux kernel to be built by Buildroot):
   `make menuconfig` → **Target packages → Hardware handling → hello-kmod**
4. Build:
   ```bash
   make
   ```
   The module is installed in the image as `/lib/modules/<kernel version>/updates/hello_kmod.ko`.

## On the target

```bash
modprobe hello_kmod      # hello_kmod: hello world
modprobe -r hello_kmod   # hello_kmod: bye bye world
```

## Standalone build (without Buildroot)

```bash
cd src
make KDIR=<kernel build dir> ARCH=arm64 CROSS_COMPILE=aarch64-linux-
```
