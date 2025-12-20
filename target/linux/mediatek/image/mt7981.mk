define Device/sl3000-emmc
  DEVICE_VENDOR := SL
  DEVICE_MODEL := SL3000
  DEVICE_VARIANT := eMMC
  DEVICE_DTS := mt7981b-sl3000-emmc
  DEVICE_DTS_DIR := $(DTS_DIR)/mediatek
  SUPPORTED_DEVICES := sl3000-emmc
  BLOCKSIZE := 128k
  PAGESIZE := 2048
  KERNEL_SIZE := 4096k
  IMAGE_SIZE := 120832k

  IMAGES += sysupgrade.bin
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata

  DEVICE_PACKAGES := kmod-usb3 kmod-usb2 kmod-leds-gpio kmod-gpio-button-hotplug \
	kmod-mt7915e kmod-mt7981-firmware mt7981-wo-firmware \
	wpad-basic-mbedtls
endef
TARGET_DEVICES += sl3000-emmc
