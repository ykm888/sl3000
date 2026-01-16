# SPDX-License-Identifier: GPL-2.0-only
# ImmortalWrt Filogic mt7981 image definitions

include ./common.mk

DTS_DIR := $(DTS_DIR)

define Device/sl3000-emmc
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000
  DEVICE_VARIANT := eMMC

  DEVICE_DTS := mt7981b-sl3000-emmc
  DEVICE_DTS_DIR := ../dts

  SUPPORTED_DEVICES := sl3000-emmc

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
    block-mount \
    uboot-envtools \
    fitblk

  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
endef

TARGET_DEVICES += sl3000-emmc
