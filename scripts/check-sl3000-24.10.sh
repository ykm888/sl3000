#!/bin/bash
set -e

# 仓库根目录 -> immortalwrt
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
SRC_DIR="$ROOT_DIR/immortalwrt"

cd "$SRC_DIR" || {
    echo "❌ 无法进入 ImmortalWrt 目录：$SRC_DIR"
    exit 1
}

echo "=== SL3000 ImmortalWrt 24.10 环境自检开始 ==="

# 1. 检查 DTS
DTS_FILE="target/linux/mediatek/dts/mt7981b-sl3000-emmc.dts"
if [ ! -f "$DTS_FILE" ]; then
    echo "❌ DTS 文件不存在：$DTS_FILE"
    exit 1
else
    echo "✅ DTS 文件存在"
fi

# 2. 检查 image/filogic.mk
MK_FILE="target/linux/mediatek/image/filogic.mk"
if [ ! -f "$MK_FILE" ]; then
    echo "❌ filogic.mk 不存在：$MK_FILE"
    exit 1
else
    echo "✅ filogic.mk 存在"
fi

# 3. 检查 .config 是否启用 SL3000
if grep -q "sl3000" .config; then
    echo "✅ .config 中已启用 SL3000"
else
    echo "❌ .config 中未启用 SL3000"
    exit 1
fi

echo "=== ✅ SL3000 ImmortalWrt 24.10 自检通过 ==="
exit 0
