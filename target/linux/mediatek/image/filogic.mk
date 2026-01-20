# SPDX-License-Identifier: GPL-2.0-only
# ImmortalWrt Filogic image definitions
# Target: mediatek/filogic

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

# DTS 统一指向内核源码树
DTS_DIR := $(LINUX_DIR)/arch/arm64/boot/dts/mediatek

# ===========================
# 官方设备定义（结构保留）
# ===========================

# 以下为官方设备占位符（不复制内容）
# define Device/mt7981-official-device-1
# define Device/mt7981-official-device-2
# define Device/mt7981-official-device-3
# ...
# TARGET_DEVICES += mt7981-official-device-1
# TARGET_DEVICES += mt7981-official-device-2
# TARGET_DEVICES += mt7981-official-device-3

# ===========================
# SL3000 eMMC 官方对齐定义
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

  # 完整驱动 + 网络 + 存储 + Docker + Passwall2
  DEVICE_PACKAGES := \
    kmod-mt76 kmod-mt7981-firmware mt7981-wo-firmware \
    kmod-mt7530 kmod-dsa kmod-dsa-mt7530 \
    kmod-mmc kmod-mmc-mtk kmod-fs-ext4 kmod-fs-btrfs kmod-dm \
    luci luci-theme-bootstrap fstools block-mount uboot-envtools fitblk \
    luci-app-passwall2 xray-core \
    shadowsocks-libev-ss-local shadowsocks-libev-ss-redir \
    shadowsocks-libev-ss-server shadowsocks-libev-ss-tunnel \
    dockerd docker docker-compose luci-app-dockerman

  # 10GB 镜像空间（适配 128GB eMMC）
  IMAGE_SIZE := 10240m

  KERNEL := kernel-bin
  KERNEL_INITRAMFS := kernel-bin
  ROOTFS := squashfs

  IMAGES := sysupgrade.bin
  IMAGE/sysupgrade.bin := append-kernel | append-rootfs | pad-rootfs | append-metadata
endef

TARGET_DEVICES += sl3000-emmc

# ===========================
# 构建镜像
# ===========================

$(eval $(call BuildImage))
