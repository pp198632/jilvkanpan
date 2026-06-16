# Codex 开发任务书：纪律观察室 MVP

## 1. 项目名称

纪律观察室。

定位：A股早盘看盘、晚间复盘、网络热点追踪、热点到A股映射、自选股纪律风控工具。

核心口号：不靠感觉交易，只按纪律观察。

## 2. 开发目标

请先实现一个本地可运行的 MVP，优先跑通完整业务闭环，而不是追求复杂数据源。

MVP 必须完成：

1. 自选股管理。
2. 早盘看盘报告生成。
3. 晚间复盘报告生成。
4. 网络热点录入、展示、评分。
5. 热点到 A股板块、概念、个股映射。
6. 仓位、止损、利好兑现、情绪过热等纪律风控提醒。
7. Markdown/HTML 报告输出。
8. CSV/Excel 手动导入。
9. Mock 数据演示。

## 3. 推荐技术栈

- Next.js 15+
- TypeScript
- Tailwind CSS
- shadcn/ui
- SQLite
- Prisma
- TanStack Table
- ECharts 或 Recharts
- markdown-it 或 remark

如果 Codex 判断全栈 Next.js 实现更高效，可以采用 Next.js App Router + Prisma + SQLite 的单体架构。

## 4. 页面结构

### 4.1 Dashboard

展示：

- 今日市场状态。
- 主要指数涨跌。
- 热点强度排行。
- 自选股风险数量。
- 今日纪律提醒。
- 最近生成的早盘/复盘报告。

### 4.2 早盘看盘

功能：

- 导入或读取昨夜外围、指数、板块、热点、自选股数据。
- 生成早盘看盘清单。
- 输出 Markdown 报告。

报告结构：

1. 今日核心判断。
2. 外围市场。
3. A股指数环境。
4. 主线热点。
5. 自选股观察。
6. 风险纪律。
7. 今日操作纪律。

### 4.3 晚间复盘

功能：

- 记录当日指数、板块、个股、热点表现。
- 对照早盘计划，标记执行情况。
- 生成晚间复盘报告。

报告结构：

1. 今日市场总结。
2. 主线是否延续。
3. 热点强弱变化。
4. 自选股表现。
5. 操作纪律执行。
6. 明日观察重点。

### 4.4 网络热点

平台包括：

- 抖音
- 快手
- 小红书
- 微博
- 雪球
- 东方财富
- 同花顺
- 百度指数或微信指数，后续扩展

MVP 阶段不做违规爬虫，先支持：

- 人工录入。
- CSV/Excel 导入。
- Mock 数据。
- 未来合规 API 适配层。

热点字段：

- 平台
- 关键词
- 热度值
- 排名
- 情绪
- 发布时间
- 摘要
- 关联概念
- 关联个股

### 4.5 热点-A股映射

功能：

- 将网络热点关键词映射到 A股概念、板块、个股。
- 支持手动维护映射字典。
- 支持评分：热度分、情绪分、持续性分、市场相关性分、风险分。

### 4.6 自选股风控

功能：

- 维护自选股。
- 记录持仓成本、仓位、止损价、目标价、交易计划。
- 自动生成纪律提示。

必须支持的风险规则：

1. 满仓状态优先提示：禁止情绪化加仓。
2. 单票仓位过高提示。
3. 跌破止损价提示。
4. 连续大涨后的利好兑现风险提示。
5. 热点退潮风险提示。
6. 高位放量滞涨提示，MVP 可先用字段模拟。

## 5. 数据导入

请实现 CSV 导入，Excel 可作为第二优先级。

建议目录：

```text
/data/mock/watchlist.csv
/data/mock/hot_topics.csv
/data/mock/market_snapshot.csv
/data/mock/sector_snapshot.csv
/data/mock/topic_stock_map.csv
```

## 6. 数据库

请参考 `docs/DATABASE_SCHEMA.sql`，用 Prisma 建模。

核心表：

- WatchlistStock
- MarketSnapshot
- SectorSnapshot
- HotTopic
- TopicStockMap
- RiskRule
- RiskAlert
- Report
- TradePlan
- ReviewLog

## 7. 评分规则

### 7.1 热点评分

```text
hot_score = platform_heat * 0.35 + rank_score * 0.2 + sentiment_score * 0.15 + duration_score * 0.15 + market_relevance_score * 0.15
```

### 7.2 风险评分

```text
risk_score = position_risk * 0.35 + price_risk * 0.25 + event_risk * 0.2 + sentiment_overheat_risk * 0.2
```

### 7.3 纪律等级

- 0-30：正常观察。
- 31-60：谨慎观察。
- 61-80：高风险，减少主观操作。
- 81-100：强风控，优先保护本金。

## 8. 报告生成

至少实现：

- 早盘报告 `morning_report_YYYY-MM-DD.md`
- 晚间复盘 `evening_review_YYYY-MM-DD.md`

输出目录：

```text
/reports/
```

## 9. 推荐项目结构

```text
jilvkanpan/
  app/
    page.tsx
    morning/page.tsx
    review/page.tsx
    hot-topics/page.tsx
    mapping/page.tsx
    watchlist/page.tsx
    reports/page.tsx
    settings/page.tsx
  components/
  lib/
    db.ts
    scoring.ts
    risk-engine.ts
    report-generator.ts
    csv-importer.ts
  prisma/
    schema.prisma
  data/mock/
  docs/
  reports/
  README.md
  package.json
```

## 10. 第一阶段验收标准

运行：

```bash
npm install
npm run dev
```

访问页面：

- `/`
- `/morning`
- `/review`
- `/hot-topics`
- `/mapping`
- `/watchlist`
- `/reports`
- `/settings`

验收：

1. Mock 数据能展示。
2. 自选股能看到风险提示。
3. 热点榜能展示评分。
4. 热点能映射到概念和个股。
5. 能生成早盘 Markdown。
6. 能生成晚间复盘 Markdown。
7. README 有清晰运行说明。

## 11. 重要边界

- 不实现自动交易。
- 不连接券商账户。
- 不提供收益承诺。
- 不绕过平台风控采集数据。
- 不把普通观察提示写成确定性买卖建议。
