# Trae AI Skills Marketplace

本地 marketplace 为 Trae AI 提供可复用的技能（skills / plugins）。

## 安装

在支持 Claude Code plugin 的环境中：

```bash
/plugin marketplace add https://github.com/MagicAn816/trae-skills.git
/plugin install stock-analysis@trae-skills-marketplace
/plugin install agent-browser@trae-skills-marketplace
/plugin install guizang-ppt-skill@trae-skills-marketplace
```

本地安装：

```bash
/plugin marketplace add .
```

## 已包含的 Plugin

| Plugin | 说明 |
|--------|------|
| `stock-analysis` | 生成专业股票分析报告（数据采集 + AI 分析 + HTML 可视化） |
| `agent-browser` | 浏览器自动化 CLI（导航、填表、截图、抓取数据） |
| `guizang-ppt-skill` | 生成横向翻页网页 PPT（电子杂志风 / 瑞士国际主义风） |

## 添加新 skill

1. 将 skill 目录放入 `.trae/skills/<skill-name>/`
2. 在该目录下创建 `.claude-plugin/plugin.json`：

```json
{
  "name": "my-skill",
  "description": "What this skill does",
  "version": "1.0.0",
  "category": "tools",
  "keywords": ["keyword1", "keyword2"]
}
```

3. 运行同步脚本自动更新 marketplace.json：

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\sync-marketplace.ps1
```

4. 提交并推送：

```bash
git add .trae\skills\my-skill\ .claude-plugin\
git commit -m "Add my-skill plugin"
git push
```

## 目录结构

```
.trae/skills/                  ← skills 存放目录
  <skill-name>/
    SKILL.md                   ← 技能定义文件
    .claude-plugin/
      plugin.json              ← Plugin 元数据
.claude-plugin/
  marketplace.json             ← Marketplace 清单（由脚本自动生成）
scripts/
  sync-marketplace.ps1         ← 扫描 skills 目录，自动更新 marketplace.json
```