#!/bin/bash
# clean-patch.sh
# 一键清理与 SL3000 无关的 patch 文件

cd target/linux/mediatek/patches-6.6 || exit 1

# 强制移除无关 patch（MT7622/MT7623/MT7968/MT7986/MT7988/BPI-R2/R3/Realtek/Airoha）
git rm -f \
  *mt7622*.patch \
  *mt7623*.patch \
  *mt7968*.patch \
  *mt7986*.patch \
  *mt7988*.patch \
  *bpi-r2*.patch \
  *bpi-r3*.patch \
  *realtek*.patch \
  *airoha*.patch \
  *mxl*.patch

# 提交删除操作
git commit -m "清理无关 patch 文件，保持 SL3000 构建干净"

# 推送到远程仓库
git push origin immortalwrt-24.10
