#!/bin/bash
# ============================================================
# diy.sh - 自定义编译脚本
# 此脚本在 feeds update 之前执行
# ============================================================

# === 修改默认 LAN IP 地址 ===
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# === 添加第三方软件包源 ===
# 优先使用 kenzok8 源，放在 feeds.conf.default 最前面覆盖默认源
sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default
