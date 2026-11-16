# Kbuild Makefile for hello_kmod.
#
# Inside Buildroot (kernel-module package), Buildroot runs the kernel's build
# system with M=<this dir>, which reads only the obj-m line below.
obj-m := hello_kmod.o

# Standalone build, e.g.:
#   make KDIR=<kernel build dir> ARCH=arm64 CROSS_COMPILE=aarch64-linux-
ifeq ($(KERNELRELEASE),)
KDIR ?= /lib/modules/$(shell uname -r)/build

default:
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules

clean:
	$(MAKE) -C $(KDIR) M=$(CURDIR) clean
endif
