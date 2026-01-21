# SPDX-License-Identifier: GPL-2.0-only
# ImmortalWrt Filogic image definitions
# Target: mediatek/filogic

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

# ===========================
# SL3000 eMMC — Ultimate Edition
# ===========================

define Device/sl3000-emmc
  # 设备基础信息
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000
  DEVICE_VARIANT := eMMC
  DEVICE_PACKAGES := 

  # 核心修复：DTS 路径与编译配置
  # 指向 target/linux/mediatek/dts 目录下的 DTS 文件
  DEVICE_DTS := mt7981b-sl3000-emmc
  DEVICE_DTS_DIR := target/linux/mediatek/dts
  DEVICE_DTS_CONFIG := config@1  # MTK 平台必须，指定 DTS 配置

  # sysupgrade 兼容性强化
  SUPPORTED_DEVICES := sl3000-emmc mt7981b-sl3000-emmc sl3000-emmc-v1
  DEVICE_COMPAT_VERSION := 1.1
  DEVICE_COMPAT_MESSAGE := "SL3000 eMMC Ultimate Edition"

  # 驱动与功能包（移除重复的 docker 包，精简依赖）
  DEVICE_PACKAGES += \
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
    dockerd docker-compose luci-app-dockerman \
    luci-app-passwall2 xray-core \
    shadowsocks-libev-ss-local shadowsocks-libev-ss-redir \
    shadowsocks-libev-ss-server shadowsocks-libev-ss-tunnel

  # 移除 USB 相关驱动（硬件无 USB 控制器）
  DEVICE_PACKAGES := $(filter-out \
    kmod-usb3 kmod-usb2 kmod-usb-storage kmod-usb-storage-uas \
    kmod-usb-ledtrig-usbport, \
    $(DEVICE_PACKAGES))

  # 镜像大小（适配大 eMMC，单位 M）
  IMAGE_SIZE := 10240m

  # 内核与根文件系统配置
  KERNEL := kernel-bin
  KERNEL_INITRAMFS := kernel-bin | lzma
  ROOTFS := squashfs
  ROOTFS_COMPRESSION := lzma  # 启用压缩，减小镜像体积

  # 输出镜像类型
  IMAGES := sysupgrade.bin initramfs-recovery.itb

  # sysupgrade 镜像打包流程（标准规范）
  IMAGE/sysupgrade.bin := \
    append-kernel | append-rootfs | pad-rootfs | \
    check-size | append-metadata | check-size

  # initramfs 恢复镜像打包流程（修复原逻辑错误）
  IMAGE/initramfs-recovery.itb := \
    export-kernel | append-dtb | pad-to 64k | \
    mkits-itb kernel-initramfs | append-metadata
endef

# 注册设备
TARGET_DEVICES += sl3000-emmc

# 构建镜像
$(eval $(call BuildImage))
