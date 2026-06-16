# 技术方案：纪律观察室 MVP

## 1. 架构选择

推荐采用 Next.js App Router 单体架构：

- 前端：Next.js + TypeScript + Tailwind CSS + shadcn/ui。
- 后端：Next.js Route Handlers 或 Server Actions。
- 数据库：SQLite。
- ORM：Prisma。
- 图表：ECharts 或 Recharts。
- 表格：TanStack Table。
- 报告：Markdown 模板生成。

MVP 重点是跑通业务闭环，真实数据源后置。

## 2. 核心模块

### 2.1 数据层

- Prisma schema。
- SQLite 本地数据库。
- Seed 脚本导入 Mock 数据。
- CSV 导入模块。

### 2.2 评分层

文件建议：`lib/scoring.ts`

函数：

- `calculateHotTopicScore(topic)`
- `calculateMarketRelevanceScore(topic, mappings)`
- `calculateRiskScore(stock, rules)`

### 2.3 风控层

文件建议：`lib/risk-engine.ts`

规则：

- 满仓风险。
- 单票仓位过高。
- 跌破止损。
- 高位利好兑现。
- 热点退潮。
- 情绪过热。

输出：

```ts
type RiskAlert = {
  level: 'LOW' | 'MEDIUM' | 'HIGH' | 'CRITICAL'
  title: string
  message: string
  stockCode?: string
  topicKeyword?: string
  createdAt: Date
}
```

### 2.4 报告层

文件建议：`lib/report-generator.ts`

函数：

- `generateMorningReport(date)`
- `generateEveningReview(date)`
- `saveReport(report)`

报告格式：Markdown。

### 2.5 导入层

文件建议：`lib/csv-importer.ts`

支持：

- `watchlist.csv`
- `hot_topics.csv`
- `market_snapshot.csv`
- `sector_snapshot.csv`
- `topic_stock_map.csv`

## 3. 推荐路由

```text
/                 Dashboard
/morning          早盘看盘
/review           晚间复盘
/hot-topics       网络热点
/mapping          热点映射
/watchlist        自选股风控
/reports          报告中心
/settings         配置中心
/api/import       数据导入
/api/reports      报告生成
/api/risk-alerts  风控提醒
```

## 4. UI组件建议

- `MarketOverviewCards`
- `HotTopicTable`
- `WatchlistRiskTable`
- `RiskAlertList`
- `ReportPreview`
- `ImportPanel`
- `MappingEditor`
- `DisciplineChecklist`

## 5. 数据处理流程

### 5.1 早盘报告

1. 读取最新市场快照。
2. 读取热点排行。
3. 读取热点映射。
4. 读取自选股。
5. 运行风控规则。
6. 生成纪律清单。
7. 输出 Markdown。

### 5.2 晚间复盘

1. 读取当日市场表现。
2. 读取板块表现。
3. 读取热点变化。
4. 读取自选股表现。
5. 汇总风险与执行偏差。
6. 输出 Markdown。

## 6. 配置文件

`.env.example`：

```env
DATABASE_URL="file:./dev.db"
APP_NAME="纪律观察室"
REPORT_OUTPUT_DIR="./reports"
```

## 7. 开发顺序

1. 初始化 Next.js 项目。
2. 安装 Tailwind、Prisma、UI 库。
3. 建立 Prisma schema。
4. 写 seed 脚本。
5. 导入 mock CSV。
6. 实现基础页面。
7. 实现评分与风控。
8. 实现报告生成。
9. 加 README 运行说明。
10. 自测所有页面。

## 8. 测试建议

- 单元测试评分函数。
- 单元测试风控规则。
- 快照测试报告模板。
- 手动测试 CSV 导入。
- 手动测试报告生成。

## 9. 数据源扩展原则

所有外部数据源必须通过 adapter 层接入：

```text
lib/data-adapters/
  manual.ts
  csv.ts
  mock.ts
  provider-x.ts
```

严禁在业务代码中直接写死第三方平台抓取逻辑。
