#!/usr/bin/env bash
set -e

echo "===== S13000 构建前检查脚本（自动检测 + fail-fast）====="

ROOT="/home/runner/immortalwrt"

CONFIG_FILE="$ROOT/.config"
DTS_FILE="$ROOT/target/linux/mediatek/dts/mt7981b-s13000-emmc.dts"
MK_FILE="$ROOT/target/linux/mediatek/image/filogic.mk"
DTS_MAKEFILE="$ROOT/target/linux/mediatek/dts/Makefile"

echo "[1] 检查 DTS 文件..."
[ -f "$DTS_FILE" ] || { echo "❌ DTS 缺失：$DTS_FILE"; exit 1; }
echo "✅ DTS 存在"

echo "[2] 检查 filogic.mk..."
grep -q "DEVICE_DTS *:= *mt7981b-s13000-emmc" "$MK_FILE" \
  || { echo "❌ filogic.mk 未对齐 DEVICE_DTS"; exit 1; }
echo "✅ filogic.mk 对齐正确"

echo "[3] 检查 DTS Makefile 注册..."
grep -q "mt7981b-s13000-emmc.dts" "$DTS_MAKEFILE" \
  || { echo "❌ DTS Makefile 未注册"; exit 1; }
echo "✅ DTS 已注册"

echo "[4] 清理 .config..."
BAD_PKGS=(asterisk onionshare pysocks unidecode uw-imap)
for pkg in "${BAD_PKGS[@]}"; do sed -i "/$pkg/d" "$CONFIG_FILE"; done
echo "✅ .config 清理完成"

echo "[5] 检查目标设备符号..."
grep -q "CONFIG_TARGET_mediatek_filogic_DEVICE_s13000_emmc=y" "$CONFIG_FILE" \
  || { echo "❌ .config 未启用 S13000 设备"; exit 1; }
echo "✅ .config 已启用 S13000"

echo "===== 所有检查通过，S13000 构建环境已准备完毕 ====="
