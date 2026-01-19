# SPDX-License-Identifier: GPL-2.0-only
# ImmortalWrt Filogic image definitions

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

# DTS 路径统一指向内核源码树
DTS_DIR := $(LINUX_DIR)/arch/arm64/boot/dts/mediatek

# ===========================
#   MT7981 / Filogic 820
# ===========================

define Device/mt7981-default
  DEVICE_VENDOR := MediaTek
  DEVICE_MODEL := MT7981 Reference Board
  DEVICE_DTS := mt7981-rfb
  DEVICE_DTS_DIR := $(DTS_DIR)
  SUPPORTED_DEVICES := mt7981-rfb
  DEVICE_PACKAGES := \
    kmod-mt76 kmod-mt7981-firmware mt7981-wo-firmware \
    kmod-mt7530 kmod-dsa kmod-dsa-mt7530 kmod-mmc kmod-mmc-mtk
  IMAGE_SIZE := 256m
  KERNEL := kernel-bin
  KERNEL_INITRAMFS := kernel-bin
  ROOTFS := squashfs
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata
endef
TARGET_DEVICES += mt7981-default

# ===========================
#   MT7988 / Filogic 880
# ===========================

define Device/mt7988-default
  DEVICE_VENDOR := MediaTek
  DEVICE_MODEL := MT7988 Reference Board
  DEVICE_DTS := mt7988-rfb
  DEVICE_DTS_DIR := $(DTS_DIR)
  SUPPORTED_DEVICES := mt7988-rfb
  DEVICE_PACKAGES := \
    kmod-mt76 kmod-mt7988-firmware \
    kmod-mt7530 kmod-dsa kmod-dsa-mt7530 kmod-mmc kmod-mmc-mtk
  IMAGE_SIZE := 512m
  KERNEL := kernel-bin
  KERNEL_INITRAMFS := kernel-bin
  ROOTFS := squashfs
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata
endef
TARGET_DEVICES += mt7988-default

# ===========================
#   SL3000 eMMC (自定义设备)
# ===========================

define Device/sl3000-emmc
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000
  DEVICE_VARIANT := eMMC
  DEVICE_DTS := mt7981b-sl3000-emmc
  DEVICE_DTS_DIR := $(DTS_DIR)
  SUPPORTED_DEVICES := sl3000-emmc mt7981b-sl3000-emmc
  DEVICE_PACKAGES := \
    kmod-mt76 \
    kmod-mt7981-firmware \
    mt7981-wo-firmware \
    kmod-mt7530 \
    kmod-dsa \
    kmod-dsa-mt7530 \
    kmod-mmc \
    kmod-mmc-mtk \
    kmod-fs-ext4 \
    kmod-fs-btrfs \
    kmod-dm \
    luci \
    luci-theme-bootstrap \
    fstools \
    block-mount \
    uboot-envtools \
    fitblk \
    luci-app-passwall2 xray-core \
    shadowsocks-libev-ss-local shadowsocks-libev-ss-redir \
    shadowsocks-libev-ss-server shadowsocks-libev-ss-tunnel \
    dockerd docker docker-compose luci-app-dockerman

  IMAGE_SIZE := 10240m
  KERNEL := kernel-bin
  KERNEL_INITRAMFS := kernel-bin
  ROOTFS := squashfs
  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata
endef
TARGET_DEVICES += sl3000-emmc
