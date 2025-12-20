#!/bin/bash
set -e

echo "=== SL3000 ImmortalWrt 24.10 增强版自检开始 ==="

# 进入 ImmortalWrt 源码目录
cd immortalwrt || {
    echo "❌ 无法进入 immortalwrt 目录"
    exit 1
}

###############################################
# 1. 检查 DTS 文件
###############################################
DTS_FILE="target/linux/mediatek/dts/mt7981b-sl3000-emmc.dts"

if [ ! -f "$DTS_FILE" ]; then
    echo "❌ DTS 文件不存在：$DTS_FILE"
    exit 1
else
    echo "✅ DTS 文件存在"
fi

###############################################
# 2. DTS 语法检查（带 include 路径）
###############################################
echo "→ 正在检查 DTS 语法..."

dtc -I dts -O dtb \
  -i target/linux/mediatek/dts \
  -i target/linux/generic/files/include \
  -i include \
  "$DTS_FILE" \
  -o /tmp/sl3000.dtb 2>/tmp/dts_err || true

if [ -s /tmp/dts_err ]; then
    echo "❌ DTS 语法错误："
    cat /tmp/dts_err
    exit 1
else
    echo "✅ DTS 语法正常"
fi

echo "=== ✅ SL3000 ImmortalWrt 24.10 自检全部通过 ==="
exit 0
