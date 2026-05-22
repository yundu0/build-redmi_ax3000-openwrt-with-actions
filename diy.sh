#!/bin/bash
# ============================================================
# diy.sh - 自定义编译脚本
# 此脚本在 feeds update 之前执行
# ============================================================

# === 修改默认 LAN IP 地址 ===
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# === 添加第三方软件包源 ===
# 优先使用 kenzok8 源，放在 feeds.conf.default 最前面覆盖默认源
sed -i '1i src-git kenzok8 https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default

# 注意：高版本 golang (v1.26) 及其它冲突包（如 xray, v2ray, etc.）的替换，
# 为了避免被 feeds update 恢复，统一在 Github Actions 工作流 (.github/workflows/) 
# 中的 `feeds update -a` 执行完毕后自动处理，此处无需再添加 golang。
