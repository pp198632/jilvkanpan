# 纪律观察室

> 不靠感觉交易，只按纪律观察。

“纪律观察室”是一个用于 A股早盘看盘、晚间复盘、网络热点追踪、热点到A股映射、自选股纪律风控的研究与复盘工具。

## 给 Codex 的入口

请优先读取：

1. `docs/CODEX_TASK.md`
2. `docs/PRD.md`
3. `docs/TECH_SPEC.md`
4. `docs/TASKS.md`
5. `docs/DATABASE_SCHEMA.sql`
6. `data/mock/*.csv`

## MVP目标

- 本地可运行。
- 支持手动导入 CSV/Excel 数据。
- 支持早盘看盘报告。
- 支持晚间复盘报告。
- 支持网络热点录入与展示。
- 支持热点到 A股题材、板块、个股映射。
- 支持自选股仓位和纪律风控提醒。
- 支持 Markdown/HTML 报告输出。

## 推荐技术栈

- Next.js + TypeScript + Tailwind CSS + shadcn/ui
- SQLite + Prisma
- ECharts/Recharts
- TanStack Table
- Markdown/HTML report generator

## 合规边界

本项目只做观察、复盘、风控和纪律提示；不做自动交易、不承诺收益、不绕过平台限制采集数据。热点数据优先使用人工录入、CSV/Excel 导入、公开授权数据或合规 API。

## MVP页面

- Dashboard 总览
- 早盘看盘
- 晚间复盘
- 网络热点
- 热点-A股映射
- 自选股风控
- 报告中心
- 配置中心
