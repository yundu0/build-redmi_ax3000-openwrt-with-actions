# 🚀 Build Redmi AX3000 / CR881x (kmiit 25.12 稳定版)

本分支（`build-zcop-immortalwrt`）目前已配置为自动编译 [kmiit/Redmi_AX3000_immortalwrt](https://github.com/kmiit/Redmi_AX3000_immortalwrt) 稳定版项目。
此项目是专为 **红米 AX3000** 及同架构的 **小米 CR881x / CR880x** 路由器定制的、基于 **ImmortalWrt 25.12 稳定发布分支** 的固件。

---

## 🌟 本分支核心特色

1. **ImmortalWrt 25.12 稳定系统架构**
   - 相比滚动迭代的开发版，25.12 稳定发布分支具有极高的运行稳定性、固定的工具链，大幅减少软件包依赖冲突。
   - 完美支持中文化，内置了多款常用的实用插件。

2. **存储扩容（mtd20 userdata 挂载补丁 - 25.12 适配版）**
   - 默认集成了修改版 `fstools` 补丁 `110-fstools-cr881x-overlay-on-mtd20-userdata.patch`（已针对 25.12 较旧版本的 fstools `mount_root.c` 进行精准重写适配，确保应用时 100% 成功）。
   - 自动挂载原厂闲置的 `mtd20` (`userdata`) UBI 卷为系统 overlay 目录，无需拆机改分区即可实现用户空间扩容。
   - 支持完美的出厂重置与恢复重置逻辑，杜绝重置变砖或报错。

---

## 📋 触发编译方法

### 1. 自动触发 (Git Push)

您只需在此分支中将改动推送到 GitHub 远程仓库即可激活构建：
```bash
git push origin build-zcop-immortalwrt
```

### 2. 手动触发 (Workflow Dispatch)

进入您 GitHub 仓库的 **Actions** → 选中 **🚀 编译 Build_RedmiAX3000_ImmortalWrt** → 选择 **build-zcop-immortalwrt** 分支点击 **Run workflow**。

| 选项 | 默认值 | 说明 |
|------|--------|------|
| openWRT 仓库的拥有者 | `kmiit` | 源码仓库 owner |
| openWRT 仓库的名字 | `Redmi_AX3000_immortalwrt` | 源码仓库名 |
| openWRT 仓库的分支 | `redmi_ax3000-25.12` | 源码分支 |
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
make menuconfig  # 调整包和驱动的选勾（用方向键 and Y/N 选择）
make defconfig   # 补全依赖
touch ~/continue && exit # ⚡ 调整完后必须执行此句以通知 Workflow 继续编译
```

---

## 🔗 源码与致谢

- 定制源码：[kmiit/Redmi_AX3000_immortalwrt](https://github.com/kmiit/Redmi_AX3000_immortalwrt) (redmi_ax3000-25.12 分支)
- 原始上游：[immortalwrt/immortalwrt](https://github.com/immortalwrt/immortalwrt)
