# 🚀 Build Redmi AX3000 ImmortalWrt

基于 GitHub Actions 自动编译 Redmi AX3000 的 ImmortalWrt 固件。

## 📋 使用方法

### 1. Fork 本仓库

### 2. 触发编译

进入 **Actions** → **🚀 编译 Build_RedmiAX3000_ImmortalWrt** → **Run workflow**，可配置以下选项：

| 选项 | 默认值 | 说明 |
|------|--------|------|
| openWRT 仓库的拥有者 | `zhouun` | 源码仓库 owner |
| openWRT 仓库的名字 | `Redmi_AX3000_immortalwrt` | 源码仓库名 |
| openWRT 仓库的分支 | `redmi_ax3000-24.10` | 源码分支 |
| SSH 连接调试 | `false` | 开启后可 SSH 进入编译环境调整配置 |
| 复制 files 自定义文件 | `true` | 是否复制 `files/` 目录到固件 |
| 执行 diy.sh 自定义脚本 | `true` | 是否执行自定义脚本 |

### 3. 获取固件

编译完成后：
- **Artifacts**：在 Actions 运行记录中下载 `OpenWrt_Firmware`
- **Release**：自动发布到仓库的 Releases 页面，附带 SHA256 校验文件

---

## 🔧 SSH 调试指南

触发 Workflow 时勾选 **「SSH 连接调试」** 即可在编译前通过 SSH 进入环境。

### 连接方式

Workflow 运行到 SSH 步骤时，Actions 日志会**循环输出**连接信息（这是正常行为，不是卡住）：

```
Warning: No public SSH keys found for xxx; continuing without them...
Web shell: https://tmate.io/t/xxxx
SSH: ssh xxxx@nyc1.tmate.io
```

### 连接方式

- **方式一（推荐）**：复制 `Web shell` 链接在浏览器中直接打开
- **方式二**：复制 `SSH` 命令在本地终端中连接

### 操作步骤

连接后按顺序执行：

```bash
# 1. 进入源码目录
cd openWRT

# 2. 打开可视化配置菜单
make menuconfig
#    - 用方向键导航，Enter 进入子菜单
#    - Y 选中，N 取消，M 设为模块
#    - / 搜索配置项
#    - 调整完后按 Esc 返回，选 Yes 保存

# 3. 补全配置（自动处理依赖）
make defconfig

# 4. （可选）查看配置变化
diff .config .config.old

# 5. ⭐ 完成后必须执行！告诉 Workflow 继续编译
# 5. ⭐ 完成后必须执行！告诉 Workflow 继续编译
touch ~/continue && exit
```

### ⚠️ 注意事项

- 执行 `touch ~/continue && exit` 后手动退出，或等待 **30分钟超时** 后 Workflow 会自动继续。
- **如果不执行就断开**，Workflow 会一直等待直到 6 小时超时（若未设置超时）或 30 分钟（已设置超时）。
- 整个 Job 时限 6 小时，SSH 调试建议控制在 30 分钟内。

---

## 📂 文件说明

| 文件/目录 | 说明 |
|-----------|------|
| `.config` | OpenWrt 编译配置文件 |
| `diy.sh` | 自定义脚本（修改 LAN IP、添加第三方 feeds 源） |
| `files/etc/uci-defaults/99-custom` | 首次启动脚本（配置 WiFi、LED、时区等） |

### diy.sh 说明

- 修改默认 LAN IP 为 `192.168.31.1`
- 添加 [kenzok8/openwrt-packages](https://github.com/kenzok8/openwrt-packages) 软件源（argon 主题、easymesh 等）
- 添加 [fw876/helloworld](https://github.com/fw876/helloworld) 软件源（SSR Plus+ 官方源，更稳定）

### 99-custom 首次启动配置

| 配置项 | 默认值 |
|--------|--------|
| LAN IP | `192.168.31.1` |
| WiFi 2.4G SSID | `Redmi_255E` |
| WiFi 5G SSID | `Redmi_255E_5G` |
| WiFi 密码 | 无（开放网络） |
| 主机名 | `Redmi_255E` |
| 时区 | `Asia/Shanghai` |
| LED | WAN 口蓝色网络状态灯 |

---

## 📦 已启用的 LuCI 插件

| 插件 | 功能 |
|------|------|
| luci-app-ssr-plus | SSR Plus+ 代理（含 SS-Rust、SSR、Xray、Hysteria） |
| luci-app-turboacc | 网络加速（BBR + PDNSD） |
| luci-app-easymesh | Mesh 组网 |
| luci-app-ddns | 动态 DNS |
| luci-app-firewall | 防火墙管理 |
| luci-app-ttyd | Web 终端 |
| luci-app-cpufreq | CPU 频率调节 |
| luci-app-filemanager | 文件管理器 |
| luci-app-argon-config | Argon 主题配置 |
| luci-app-timedreboot | 定时重启 |
| luci-app-package-manager | 软件包管理 |

---

## 🔗 源码来源

- 源码仓库：[zhouun/Redmi_AX3000_immortalwrt](https://github.com/zhouun/Redmi_AX3000_immortalwrt)
- 原始来源：[kmiit/Redmi_AX3000_immortalwrt](https://github.com/kmiit/Redmi_AX3000_immortalwrt)
