#!/bin/bash
# force-clean-patch.sh
# 强制清理残留无关 patch 文件（即使本地已 rm）

cd target/linux/mediatek/patches-6.6 || exit 1

# 找出所有无关 patch 文件并强制从 Git 索引移除
git ls-files | grep '\.patch$' | grep -E 'mt7622|mt7623|mt7968|mt7986|mt7988|bpi-r2|bpi-r3|realtek|airoha|mxl' | xargs -r git rm --cached -f

# 提交删除操作
git commit -m "强制清理残留无关 patch 文件，保持 SL3000 构建干净"

# 推送到远程仓库
git push origin immortalwrt-24.10
