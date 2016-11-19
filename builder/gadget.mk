include common.mk

OEM_UBOOT_BIN := gadget/u-boot.bin
OEM_SNAP := $(OUTPUT_DIR)/lemaker-guitar_16.04-*.snap

# for preloader packaging
ifneq "$(findstring ARM, $(shell grep -m 1 'model name.*: ARM' /proc/cpuinfo))" ""
BOOTLOADER_PACK=bootloader_pack.arm
else
BOOTLOADER_PACK=bootloader_pack
endif

all: build

clean:
	rm -f $(OEM_UBOOT_BIN)
	rm -f $(OEM_BOOT_DIR)/uboot.conf
	rm -f $(OEM_BOOT_DIR)/bootloader.bin
	rm -f $(OEM_BOOT_DIR)/uboot.env
	rm -f $(OEM_SNAP)
distclean: clean

pre-update:
	sed -i 's/fdtfile=.*/fdtfile=$(KERNEL_DTS).dtb/' $(OEM_BOOT_DIR)/uboot.env.in
	sed -i 's/device-tree:.*/device-tree: $(KERNEL_DTS).dtb/' $(OEM_BOOT_DIR)/meta/gadget.yaml

u-boot:
	@if [ ! -f $(UBOOT_BIN) ] ; then echo "Build u-boot first."; exit 1; fi
		cp -f $(UBOOT_BIN) $(OEM_UBOOT_BIN)

preload:
	cd $(TOOLS_DIR)/utils && ./$(BOOTLOADER_PACK) $(OWL_DIR)/$(IC_NAME)/bootloader/bootloader.bin $(OWL_DIR)/$(IC_NAME)/boards/$(BOARD_NAME)/bootloader.ini $(OEM_BOOT_DIR)/bootloader.bin
	mkenvimage -r -s 131072  -o $(OEM_BOOT_DIR)/uboot.env $(OEM_BOOT_DIR)/uboot.env.in
	@if [ ! -f $(UBOOT_CONF) ]; then cd $(OEM_BOOT_DIR) && ln -s uboot.env uboot.conf ; fi

snappy:
	snapcraft snap gadget

gadget: pre-update preload u-boot snappy

build: gadget

.PHONY: u-boot snappy gadget build
