# SPDX-License-Identifier: GPL-2.0-only
# ImmortalWrt Filogic image definitions
# Target: mediatek/filogic

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

# DTS 统一指向内核源码树（ImmortalWrt 6.12 必须）
DTS_DIR := $(LINUX_DIR)/arch/arm64/boot/dts/mediatek

# ===========================
# SL3000 eMMC — Flagship Edition
# ===========================

define Device/sl3000-emmc
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000
  DEVICE_VARIANT := eMMC

  # DTS 文件名（位于内核树）
  DEVICE_DTS := mt7981b-sl3000-emmc
  DEVICE_DTS_DIR := $(DTS_DIR)

  # sysupgrade 兼容 ID
  SUPPORTED_DEVICES := sl3000-emmc mt7981b-sl3000-emmc

  # ===========================
  # 旗舰级驱动链
  # ===========================
  DEVICE_PACKAGES := \
    kmod-mt76 kmod-mt7981-firmware mt7981-wo-firmware \
    kmod-mt7530 kmod-dsa kmod-dsa-mt7530 \
    kmod-mtk-hnat kmod-mt7981-wed \
    kmod-usb3 kmod-usb-storage kmod-usb-storage-uas \
    kmod-mmc kmod-mmc-mtk \
    kmod-fs-ext4 kmod-fs-btrfs kmod-dm \
    blockd fstrim fitblk fstools block-mount uboot-envtools \
    luci luci-theme-bootstrap \
    dockerd docker docker-compose luci-app-dockerman \
    luci-app-passwall2 xray-core \
    shadowsocks-libev-ss-local shadowsocks-libev-ss-redir \
    shadowsocks-libev-ss-server shadowsocks-libev-ss-tunnel

  # ===========================
  # 镜像大小（适配大 eMMC）
  # ===========================
  IMAGE_SIZE := 10240m

  # ===========================
  # Kernel / Rootfs
  # ===========================
  KERNEL := kernel-bin
  KERNEL_INITRAMFS := kernel-bin
  ROOTFS := squashfs

  # ===========================
  # 镜像格式（官方结构）
  # ===========================
  IMAGES := sysupgrade.bin initramfs-recovery.itb

  IMAGE/sysupgrade.bin := \
    append-kernel | append-rootfs | pad-rootfs | append-metadata

  IMAGE/initramfs-recovery.itb := \
    append-kernel | pad-to 64k | append-dtb | uImage none
endef

TARGET_DEVICES += sl3000-emmc

# ===========================
# 构建镜像
# ===========================
$(eval $(call BuildImage))