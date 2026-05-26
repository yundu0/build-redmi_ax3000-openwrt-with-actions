# 🚀 Build Redmi AX3000 / CR881x (Zcop ImmortalWrt)

本分支基于 GitHub Actions 自动编译 [zcop/immortalwrt](https://github.com/zcop/immortalwrt) 源码项目。
此项目是专为 **红米 AX3000** 及同架构的 **小米 CR881x / CR880x** 路由器定制的极客版 ImmortalWrt 固件。

---

## 🌟 本分支核心特色

1. **裕太微 YT921x 增强型交换芯片 DSA 驱动**
   - 集成并支持硬件 VLAN 划分（802.1Q）、硬件 FDB 自动学习与老化、硬件组播复制（MDB）。
   - 支持网络限速硬件卸载，包括 `tc mqprio`、`tc ets`、`tc tbf`、Ingress Policer。
   - 支持 `tc flower` ACL（访问控制列表）硬件卸载（如硬件重写 DSCP）。
   - 默认集成可视化的 `luci-app-cr881x-yt921x-qos` 交换芯片硬件限速控制前端。

2. **双 CPU 上行链路分流 (Dual Conduit)**
   - 依托设备树（DTS）优化，分别把 eth0、eth1 网卡设为 `secondary-conduit` 和 `primary-conduit`。
   - 局域网桥接流量与广域网流量在物理 CPU 网口上分流，大幅提高吞吐极限，并减轻单核软中断（softirq）负担。
   - 内置 `openwrt-wan-conduit-manager` 服务与 `luci-app-cr881x-wan-mode` 应用，可在 Web 端一键切换和管理上行链路。

3. **存储扩容（mtd20 userdata 挂载补丁）**
   - 默认集成了修改版 `fstools` 补丁 `110-fstools-cr881x-overlay-on-mtd20-userdata.patch`。
   - 自动挂载原厂闲置的 `mtd20` (`userdata`) UBI 卷为系统 overlay 目录，无需拆机改分区即可实现用户空间扩容。
   - 支持完美的出厂重置与恢复重置逻辑，杜绝重置变砖或报错。

4. **运存优化与包精简**
   - 剔除无用的 USB 控制器挂载组件（由于原机无 USB 口），节省空间与内存。
   - 自动关闭并剔除常驻后台的 `ubihealthd` 服务，多释放出约 2MB 物理运存。
   - 默认将 dnsmasq 改为基础版，并修复了 WiFi 标定加载异常的问题。

---

## 📋 触发编译方法

### 1. 自动触发 (Git Push)

您只需在此分支中将改动推送到 GitHub 远程仓库即可激活构建：
```bash
git push origin build-zcop-immortalwrt
```

### 2. 手动触发 (Workflow Dispatch)

进入您 GitHub 仓库的 **Actions** → 选中 **🚀 编译 Build_RedmiAX3000_Zcop_ImmortalWrt** → 选择 **build-zcop-immortalwrt** 分支点击 **Run workflow**。

| 选项 | 默认值 | 说明 |
|------|--------|------|
| openWRT 仓库的拥有者 | `zcop` | 源码仓库 owner |
| openWRT 仓库的名字 | `immortalwrt` | 源码仓库名 |
| openWRT 仓库的分支 | `master` | 源码分支 |
| SSH 连接调试 | `false` | 开启后可 SSH 进入编译环境调整配置 |
| 复制 files 自定义文件 | `true` | 是否复制 `files/` 目录到固件 |
| 执行 diy.sh 自定义脚本 | `true` | 是否执行自定义脚本 |

---

## 🔧 SSH 调试指南

如果在启动 Workflow 时勾选了 **「SSH 连接调试」**，编译前工作流会暂停 30 分钟等待连接。

### 1. 获取连接方式
在 Action 运行日志中展开 **📡 SSH 连接调试**，会看到输出：
```
Web shell: https://tmate.io/t/xxxx
SSH: ssh xxxx@nyc1.tmate.io
```
- **方式一**：复制 `Web shell` 链接在浏览器中打开直接调试。
- **方式二**：复制 `SSH` 命令在本地终端窗口中连接。

### 2. 交互调试命令
连接上后，可执行：
```bash
cd openWRT
make menuconfig  # 调整包和驱动的选勾（用方向键和 Y/N 选择）
make defconfig   # 补全依赖
touch ~/continue && exit # ⚡ 调整完后必须执行此句以通知 Workflow 继续编译
```

---

## 🔗 源码与致谢

- 核心定制源码：[zcop/immortalwrt](https://github.com/zcop/immortalwrt)
- 双 CPU / QoS 组件：[zcop/luci-app-cr881x-yt921x-qos](https://github.com/zcop/luci-app-cr881x-yt921x-qos)
- 原始上游：[immortalwrt/immortalwrt](https://github.com/immortalwrt/immortalwrt)
