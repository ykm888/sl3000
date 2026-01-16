# SPDX-License-Identifier: GPL-2.0-only
# ImmortalWrt Filogic mt7981 image definitions

include ./common.mk

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


#############################################################
#  官方设备段（ImmortalWrt 自带的设备）保持不动
#############################################################

# （这里会有官方的 mt7981 设备段，例如：
#   Device/mt7981-xyz
#   Device/mt7981-abc
#   ……你 fork 的仓库里已经有这些，不需要我重写）
# 我不会动它们，你只需要把 SL3000 设备段加在最后即可。


#############################################################
#  SL3000 — EMMC 设备段（你需要的）
#############################################################

define Device/sl3000-emmc
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000
  DEVICE_VARIANT := EMMC

  DEVICE_DTS := mt7981b-sl3000-emmc
  DEVICE_DTS_DIR := ../dts

  DEVICE_PACKAGES := \
    kmod-usb3 \
    kmod-usb2 \
    kmod-mt76 \
    kmod-mt7981-firmware \
    mt7981-wo-firmware \
    kmod-mt7530 \
    kmod-dsa \
    kmod-dsa-mt7530 \
    kmod-mmc \
    kmod-mmc-mtk \
    luci \
    luci-theme-bootstrap \
    fstools \
    block-mount

  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata

  SUPPORTED_DEVICES := sl3000-emmc
endef

TARGET_DEVICES += sl3000-emmc
