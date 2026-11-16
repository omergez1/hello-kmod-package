# hello-kmod-package

Hello-world Linux kernel module for the Raspberry Pi 5, packaged to be built by Buildroot as a kernel-module package.

The module prints `hello world` when loaded and `bye bye world` when unloaded.

## Files

| File | Description |
|---|---|
| `hello_kmod.c` | Module source |
| `Makefile` | Kbuild Makefile (`obj-m := hello_kmod.o`), usable by Buildroot or standalone |

## Building with Buildroot

Buildroot downloads this repository and builds it with the `kernel-module` infrastructure. The package directory `package/hello-kmod/` contains:

`hello-kmod.mk`
```make
HELLO_KMOD_VERSION = <commit sha>
HELLO_KMOD_SITE = $(call github,omergez1,hello-kmod-package,$(HELLO_KMOD_VERSION))
HELLO_KMOD_LICENSE = GPL-2.0

$(eval $(kernel-module))
$(eval $(generic-package))
```

`Config.in`
```
config BR2_PACKAGE_HELLO_KMOD
	bool "hello-kmod"
	depends on BR2_LINUX_KERNEL
	help
	  Hello-world kernel module.
```

…plus `hello-kmod.hash` (sha256 of the downloaded tarball) and a `source "package/hello-kmod/Config.in"` line in `package/Config.in`.

Enable it with `make menuconfig` (**Target packages → Hardware handling → hello-kmod**) and rebuild. On the target:

```bash
modprobe hello_kmod
modprobe -r hello_kmod
```

## Standalone build

```bash
make KDIR=<kernel build dir> ARCH=arm64 CROSS_COMPILE=aarch64-linux-
```
