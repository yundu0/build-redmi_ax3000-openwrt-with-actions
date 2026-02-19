#!/bin/bash
# ============================================================
# diy.sh - 自定义编译脚本
# 此脚本在 feeds update 之前执行
# ============================================================

# === 修改默认 LAN IP 地址 ===
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# === 添加第三方软件包源 ===
# 只使用 kenzok8 的两个源即可，包含 SSR Plus+、Passwall 等常用插件及其依赖
# 注意：不要同时添加 kiddin9，会与 kenzok8 产生大量重复包导致冲突
echo 'src-git kenzok8 https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
