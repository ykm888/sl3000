# SPDX-License-Identifier: GPL-2.0-only
# ImmortalWrt Filogic image definitions
# Target: mediatek/filogic

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

# DTS 统一指向内核源码树（ImmortalWrt 6.12 必须）
DTS_DIR := $(LINUX_DIR)/arch/arm64/boot/dts/mediatek

# ===========================
# SL3000 eMMC — Ultimate Edition
# ===========================

define Device/sl3000-emmc
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000
  DEVICE_VARIANT := eMMC

  # DTS 文件名（位于内核树）
  DEVICE_DTS := mt7981b-sl3000-emmc
  DEVICE_DTS_DIR := $(DTS_DIR)

  # sysupgrade 兼容 ID
  SUPPORTED_DEVICES := sl3000-emmc mt7981b-sl3000-emmc sl3000-emmc-v1

  # ===========================
  # 旗舰级驱动链（与终极 DTS 完全一致）
  # ===========================
  DEVICE_PACKAGES := \
    kmod-mt76 kmod-mt7981-firmware mt7981-wo-firmware \
    kmod-mt7530 kmod-dsa kmod-dsa-mt7530 \
    kmod-mtk-hnat kmod-mt7981-wed \
    kmod-mmc kmod-mmc-mtk \
    kmod-leds-gpio kmod-button-hotplug \
    kmod-nvmem kmod-nvmem-mtk-efuse \
    kmod-hwmon-core kmod-hwmon-mtk \
    kmod-pstore kmod-pstore-ram \
    kmod-fs-ext4 kmod-fs-btrfs kmod-fs-f2fs kmod-dm \
    blockd fstrim fitblk fstools block-mount uboot-envtools \
    irqbalance ethtool tcpdump-mini htop \
    luci luci-theme-bootstrap \
    dockerd docker docker-compose luci-app-dockerman \
    luci-app-passwall2 xray-core \
    shadowsocks-libev-ss-local shadowsocks-libev-ss-redir \
    shadowsocks-libev-ss-server shadowsocks-libev-ss-tunnel

  # ===========================
  # 移除 USB（SL3000 无 USB 控制器）
  # ===========================
  DEVICE_PACKAGES := $(filter-out \
    kmod-usb3 kmod-usb2 kmod-usb-storage kmod-usb-storage-uas \
    kmod-usb-ledtrig-usbport, \
    $(DEVICE_PACKAGES))

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
  # 镜像格式（官方结构 + 校验）
  # ===========================
  IMAGES := sysupgrade.bin initramfs-recovery.itb

  IMAGE/sysupgrade.bin := \
    append-kernel | append-rootfs | pad-rootfs | \
    check-size | append-metadata

  IMAGE/initramfs-recovery.itb := \
    append-kernel | pad-to 64k | append-dtb | \
    uImage none | append-metadata
endef

TARGET_DEVICES += sl3000-emmc

# ===========================
# 构建镜像
# ===========================
$(eval $(call BuildImage))