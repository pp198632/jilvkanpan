# 给 Codex 的启动提示词

请读取本仓库文档并开发“纪律观察室”MVP。

优先阅读顺序：

1. README.md
2. docs/CODEX_TASK.md
3. docs/PRD.md
4. docs/TECH_SPEC.md
5. docs/TASKS.md
6. docs/DATABASE_SCHEMA.sql
7. data/mock/*.csv

开发要求：

- 先创建可本地运行的 Next.js + TypeScript 项目。
- 使用 SQLite + Prisma。
- 使用 Tailwind CSS 和基础 UI 组件。
- 使用 Mock 数据跑通完整流程。
- 实现 Dashboard、早盘看盘、晚间复盘、网络热点、热点映射、自选股风控、报告中心、配置中心。
- 实现 Markdown 报告生成。
- 实现 CSV 导入。
- 实现基础评分和风控规则。

第一阶段只需要 MVP，不需要接入真实交易、不需要自动下单、不需要违规采集第三方平台数据。

完成后请确保：

```bash
npm install
npm run dev
```

能够正常启动，并在 README 中补充实际运行方式。
