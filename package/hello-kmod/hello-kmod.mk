################################################################################
#
# hello-kmod
#
################################################################################

HELLO_KMOD_VERSION = 1.0
HELLO_KMOD_SITE = $(call github,omergez1,hello-kmod-package,v$(HELLO_KMOD_VERSION))
HELLO_KMOD_LICENSE = GPL-2.0
HELLO_KMOD_MODULE_SUBDIRS = src

$(eval $(kernel-module))
$(eval $(generic-package))
