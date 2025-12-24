define Device/sl3000
  DEVICE_VENDOR := SL
  DEVICE_MODEL := 3000
  DEVICE_DTS := mt7981b-sl3000-emmc
  IMAGE_SIZE := 256m
  SUPPORTED_DEVICES := sl3000
  DEVICE_PACKAGES := \
    kmod-mt7981-firmware \
    kmod-mt76 \
    kmod-mt76-core \
    kmod-mt76-connac \
    kmod-leds-gpio \
    kmod-gpio-button-hotplug \
    block-mount \
    kmod-fs-ext4 \
    kmod-mmc \
    kmod-mmc-mtk \
    dnsmasq-full \
    ppp-mod-pppoe \
    luci \
    luci-base \
    luci-mod-admin-full \
    luci-theme-bootstrap \
    luci-app-opkg \
    luci-ssl \
    luci-i18n-base-zh-cn
endef

TARGET_DEVICES += sl3000
