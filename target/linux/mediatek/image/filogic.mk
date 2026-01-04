DTS_DIR := $(DTS_DIR)/mediatek
DEVICE_VARS += SUPPORTED_TELTONIKA_DEVICES
DEVICE_VARS += SUPPORTED_TELTONIKA_HW_MODS

define Image/Prepare
    rm -f $(KDIR)/ubi_mark
    echo -ne '\xde\xad\xc0\xde' > $(KDIR)/ubi_mark
endef

define Build/fit-with-netgear-top-level-rootfs-node
    $(call Build/fit-its,$(1))
    $(TOPDIR)/scripts/gen_netgear_rootfs_node.sh $(KERNEL_BUILD_DIR)/root.squashfs > $@.rootfs
    awk '/configurations/ { system("cat $@.rootfs") } 1' $@.its > $@.its.tmp
    @mv -f $@.its.tmp $@.its
    @rm -f $@.rootfs
    $(call Build/fit-image,$(1))
endef

define Build/mt7981-bl2
    cat $(STAGING_DIR_IMAGE)/mt7981-$1-bl2.img >> $@
endef

define Build/mt7981-bl31-uboot
    cat $(STAGING_DIR_IMAGE)/mt7981_$1-u-boot.fip >> $@
endef

define Build/mt798x-gpt
    cp $@ $@.tmp 2>/dev/null || true
    ptgen -g -o $@.tmp -a 1 -l 1024 \
        -t 0x83 -N ubootenv -r -p 512k@4M \
        -t 0xef -N fip      -r -p 4M@6656k \
        -t 0x2e -N production -p $(CONFIG_TARGET_ROOTFS_PARTSIZE)M@64M
    cat $@.tmp >> $@
    rm $@.tmp
endef

define Build/simplefit
    cp $@ $@.tmp 2>/dev/null || true
    ptgen -g -o $@.tmp -a 1 -l 1024 \
        -t 0x2e -N FIT -p $(CONFIG_TARGET_ROOTFS_PARTSIZE)M@17k
    cat $@.tmp >> $@
    rm $@.tmp
endef

# ============================
# 你的设备定义（唯一保留）
# ============================

define Device/sl3000-emmc
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000
  DEVICE_VARIANT := EMMC
  DEVICE_DTS := mt7981b-sl3000-emmc
  DEVICE_DTS_DIR := ../dts
  DEVICE_PACKAGES := kmod-usb3 kmod-mt76 kmod-mt7981-firmware mt7981-wo-firmware
  IMAGES := sysupgrade.bin
  KERNEL := kernel-bin | lzma | fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb
  KERNEL_INITRAMFS := kernel-bin | lzma | \
    fit lzma $$(KDIR)/image-$$(firstword $$(DEVICE_DTS)).dtb with-initrd | pad-to 64k
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
endef
TARGET_DEVICES += sl3000-emmc
