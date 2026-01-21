#!/bin/bash
# clean-dts.sh
# 一键清理 DTS 文件，去掉 BOM、非 ASCII 字符和乱码注释

FILE=$1

if [ -z "$FILE" ]; then
    echo "用法: $0 <dts文件路径>"
    exit 1
fi

# 1. 去掉 UTF-8 BOM
sed -i '1s/^\xEF\xBB\xBF//' "$FILE"

# 2. 删除所有非 ASCII 字符
LC_ALL=C sed -i 's/[^[:print:]\t]//g' "$FILE"

# 3. 删除包含乱码的注释行（匹配不可见字符的注释）
sed -i '/\/\*.*M-.*\*\//d' "$FILE"

# 4. 确保文件开头是干净的 DTS 头
sed -i '1,5c /dts-v1/;\n\n/* SoC 基础层 */\n#include "mt7981b.dtsi"\n#include <dt-bindings/gpio/gpio.h>\n#include <dt-bindings/input/input.h>' "$FILE"

echo "清理完成: $FILE"
