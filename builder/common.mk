CPUS := $(shell getconf _NPROCESSORS_ONLN)

include .config 

OUTPUT_DIR := $(PWD)
OWL_DIR := $(PWD)/owl-actions
SCRIPT_DIR := $(OWL_DIR)/scripts
TOOLS_DIR := $(OWL_DIR)/tools
CONFIG_DIR := $(OUTPUT_DIR)/config/$(IC_NAME)/$(BOARD_NAME)
OEM_BOOT_DIR := $(OUTPUT_DIR)/gadget

# VENDOR: toolchain from BSP ; DEB: toolchain from deb
TOOLCHAIN := DEB

KERNEL_REPO := https://github.com/LeMaker/linux-actions.git
KERNEL_BRANCH := linux-3.10.y-snappy
KERNEL_SRC := $(PWD)/kernel
KERNEL_MODULES := $(PWD)/kernel-build
KERNEL_OUT := $(PWD)/kernel-build
KERNEL_UIMAGE := $(KERNEL_OUT)/arch/arm/boot/zImage
KERNEL_DTB := $(KERNEL_OUT)/arch/arm/boot/dts/$(KERNEL_DTS).dtb

UBOOT_REPO := https://github.com/LeMaker/u-boot-actions.git
UBOOT_BRANCH := s500-snappy
UBOOT_SRC := $(PWD)/u-boot
UBOOT_OUT := $(PWD)/u-boot-build
UBOOT_BIN := $(UBOOT_OUT)/u-boot-dtb.img
UBOOT_CONF := $(OEM_BOOT_DIR)/uboot.conf

UDF := $(TOOLS_DIR)/ubuntu-device-flash

ifeq ($(TOOLCHAIN),VENDOR)
CC :=
else
CC := arm-linux-gnueabihf-
endif
