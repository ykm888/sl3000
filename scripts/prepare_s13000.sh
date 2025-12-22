#!/bin/sh
set -e

ROOT="/mnt/immortalwrt"
REPO="$GITHUB_WORKSPACE"

echo "=== Prepare S13000 triple-set ==="

# ✅ 前置检查：仓库 DTS 是否存在
if [ ! -f "$REPO/dts/mt7981b-s13000-emmc.dts" ]; then
    echo "❌ 仓库缺少 DTS 文件：mt7981b-s13000-emmc.dts"
    exit 1
fi

# 1. DTS
cp -f "$REPO/dts/mt7981b-s13000-emmc.dts" \
  "$ROOT/target/linux/mediatek/dts/"

# 2. filogic.mk
cp -f "$REPO/image/filogic.mk" \
  "$ROOT/target/linux/mediatek/image/filogic.mk"

# 3. config
cp -f "$REPO/configs/s13000.config" \
  "$ROOT/.config"
