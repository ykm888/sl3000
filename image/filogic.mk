# SPDX-License-Identifier: GPL-2.0-only
#
# Copyright (C) 2023 ImmortalWrt
#

include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk

KERNEL_LOADADDR := 0x44000000

define Build/fit
    $(call Build/fit_generic,$(1),$(2))
endef

define Build/boot-img
    $(call Build/boot-img-generic,$(1),$(2))
endef

define Build/mtk-boot
    $(call Build/mtk-boot-generic,$(1),$(2))
endef

define Build/mtk-uboot
    $(call Build/mtk-uboot-generic,$(1),$(2))
endef

define Build/mtk-fip
    $(call Build/mtk-fip-generic,$(1),$(2))
endef

define Build/mtk-preloader
    $(call Build/mtk-preloader-generic,$(1),$(2))
endef

define Build/mtk-recovery
    $(call Build/mtk-recovery-generic,$(1),$(2))
endef

define Build/mtk-factory
    $(call Build/mtk-factory-generic,$(1),$(2))
endef

define Device/Default
  PROFILES := Default
  DEVICE_DTS_DIR := $(DTS_DIR)/mediatek
  KERNEL_NAME := Image
  KERNEL := kernel-bin | fit
  KERNEL_INITRAMFS := kernel-bin | fit
  KERNEL_SUFFIX := -recovery.itb
  KERNEL_INITRAMFS_SUFFIX := -initramfs-recovery.itb
  IMAGES := sysupgrade.itb
  IMAGE/sysupgrade.itb := sysupgrade-tar | append-metadata
endef


#############################################################
# 官方 Filogic 设备（保持原样）
#############################################################

define Device/cmcc_rax3000m-emmc
  DEVICE_VENDOR := CMCC
  DEVICE_MODEL := RAX3000M
  DEVICE_VARIANT := eMMC
  DEVICE_DTS := mt7981b-rax3000m-emmc
  DEVICE_PACKAGES := kmod-mt7915e kmod-mt7981-firmware uboot-envtools block-mount
endef
TARGET_DEVICES += cmcc_rax3000m-emmc

define Device/cmcc_rax3000m-nand
  DEVICE_VENDOR := CMCC
  DEVICE_MODEL := RAX3000M
  DEVICE_VARIANT := NAND
  DEVICE_DTS := mt7981b-rax3000m-nand
  DEVICE_PACKAGES := kmod-mt7915e kmod-mt7981-firmware uboot-envtools
endef
TARGET_DEVICES += cmcc_rax3000m-nand

define Device/cmcc_rax3000me-emmc
  DEVICE_VENDOR := CMCC
  DEVICE_MODEL := RAX3000ME
  DEVICE_VARIANT := eMMC
  DEVICE_DTS := mt7981b-rax3000me-emmc
  DEVICE_PACKAGES := kmod-mt7915e kmod-mt7981-firmware uboot-envtools block-mount
endef
TARGET_DEVICES += cmcc_rax3000me-emmc


#############################################################
# ✅ SL3000 — 你的设备（完整版）
#############################################################

define Device/sl3000_emmc
  DEVICE_VENDOR := Siluoxing
  DEVICE_MODEL := SL3000
  DEVICE_VARIANT := eMMC
  DEVICE_DTS := mt7981b-sl3000-emmc
  DEVICE_DTS_DIR := $(DTS_DIR)/mediatek

  # WiFi：MT7981 内置 + MT7976CN 外挂
  DEVICE_PACKAGES := \
        kmod-mt7915e kmod-mt7981-firmware \
        kmod-mt7996e kmod-mt7996-firmware \
        kmod-mmc kmod-mmc-mtk kmod-spi-dev \
        uboot-envtools block-mount

  # 固件格式（24.10 标准）
  KERNEL := kernel-bin | fit
  KERNEL_SUFFIX := -recovery.itb
  KERNEL_INITRAMFS_SUFFIX := -initramfs-recovery.itb

  IMAGES := sysupgrade.itb
  IMAGE/sysupgrade.itb := sysupgrade-tar | append-metadata
endef
TARGET_DEVICES += sl3000_emmc
