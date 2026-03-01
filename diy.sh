#!/bin/bash
# ============================================================
# diy.sh - 自定义编译脚本
# 此脚本在 feeds update 之前执行
# ============================================================

# === 修改默认 LAN IP 地址 ===
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# === 添加第三方软件包源 ===
# kenzok8/openwrt-packages: argon 主题、easymesh 等插件
# kenzok8/small: 包含更新的各类代理软件及其依赖
echo 'src-git kenzok8 https://github.com/kenzok8/openwrt-packages' >> feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >> feeds.conf.default
