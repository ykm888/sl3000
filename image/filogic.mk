define Device/s13000_emmc
  DEVICE_VENDOR := S13000
  DEVICE_MODEL := S13000 eMMC
  DEVICE_DTS := mt7981b-s13000-emmc
  DEVICE_PACKAGES := kmod-mt7981-firmware \
                     kmod-usb3 kmod-usb2 \
                     kmod-leds-gpio kmod-gpio-button-hotplug
endef
TARGET_DEVICES += s13000_emmc
