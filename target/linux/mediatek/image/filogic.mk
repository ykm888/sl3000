# SPDX-License-Identifier: GPL-2.0-only
# Filogic platform image definitions

DTS_DIR := $(DTS_DIR)

define Build/mt798x-gpt
	cp $@ $@.tmp 2>/dev/null || true
	ptgen -g -o $@.tmp -a 1 -l 1024 \
		-t 0x2e -N production -p $(CONFIG_TARGET_ROOTFS_PARTSIZE)M@64M
	cat $@.tmp >> $@
	rm $@.tmp
endef

metadata_gl_json = \
	'{ \
		"metadata_version": "1.1", \
		"version": { \
			"release": "$(call json_quote,$(VERSION_NUMBER))", \
			"dist": "$(call json_quote,$(VERSION_DIST))", \
			"revision": "$(call json_quote,$(REVISION))", \
			"target": "$(call json_quote,$(TARGETID))", \
			"board": "$(call json_quote,$(if $(BOARD_NAME),$(BOARD_NAME),$(DEVICE_NAME)))" \
		}, \
		"supported_devices": ["$(SUPPORTED_DEVICES)"] \
	}'

define Build/append-gl-metadata
	$(if $(SUPPORTED_DEVICES),echo $(metadata_gl_json) | fwtool -I - $@)
	sha256sum "$@" | cut -d" " -f1 > "$@.sha256sum"
endef

define Device/sl3000-emmc
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000
  DEVICE_VARIANT := EMMC

  DEVICE_DTS := mt7981b-sl3000-emmc
  DEVICE_DTS_DIR := $(DTS_DIR)/mediatek

  SUPPORTED_DEVICES := sl3000-emmc

  DEVICE_PACKAGES := \
    kmod-usb3 \
    kmod-mt76 \
    kmod-mt7981-firmware \
    mt7981-wo-firmware \
    kmod-mt7530 \
    kmod-dsa \
    kmod-dsa-mt7530 \
    luci \
    luci-theme-bootstrap \
    fstools block-mount

  IMAGES := sysupgrade.bin initramfs-kernel.bin

  KERNEL := kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb
  KERNEL_INITRAMFS := kernel-bin | lzma | \
        fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb with-initrd | pad-to 64k

  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata | append-gl-metadata | mt798x-gpt
  IMAGE/initramfs-kernel.bin := append-dtb | uImage lzma
endef
TARGET_DEVICES += sl3000-emmc
