-- 纪律观察室 MVP 数据库结构草案

CREATE TABLE watchlist_stocks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  market TEXT,
  sector TEXT,
  concepts TEXT,
  current_price REAL,
  cost_price REAL,
  position_percent REAL DEFAULT 0,
  stop_loss_price REAL,
  target_price REAL,
  status TEXT DEFAULT 'WATCHING',
  notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE market_snapshots (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  trade_date TEXT NOT NULL,
  index_code TEXT NOT NULL,
  index_name TEXT NOT NULL,
  close_price REAL,
  change_percent REAL,
  turnover_amount REAL,
  market_breadth TEXT,
  notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE sector_snapshots (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  trade_date TEXT NOT NULL,
  sector_name TEXT NOT NULL,
  change_percent REAL,
  turnover_amount REAL,
  leading_stock_code TEXT,
  leading_stock_name TEXT,
  strength_score REAL,
  notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE hot_topics (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  platform TEXT NOT NULL,
  keyword TEXT NOT NULL,
  rank INTEGER,
  heat_value REAL,
  sentiment TEXT DEFAULT 'NEUTRAL',
  summary TEXT,
  related_concepts TEXT,
  related_stocks TEXT,
  collected_at DATETIME,
  hot_score REAL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE topic_stock_maps (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  keyword TEXT NOT NULL,
  concept TEXT,
  sector TEXT,
  stock_code TEXT,
  stock_name TEXT,
  relevance_score REAL DEFAULT 50,
  notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE risk_rules (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  rule_code TEXT NOT NULL UNIQUE,
  rule_name TEXT NOT NULL,
  rule_type TEXT NOT NULL,
  threshold_value REAL,
  enabled INTEGER DEFAULT 1,
  description TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE risk_alerts (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  alert_date TEXT NOT NULL,
  level TEXT NOT NULL,
  title TEXT NOT NULL,
  message TEXT NOT NULL,
  stock_code TEXT,
  topic_keyword TEXT,
  risk_score REAL,
  resolved INTEGER DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE reports (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  report_date TEXT NOT NULL,
  report_type TEXT NOT NULL,
  title TEXT NOT NULL,
  content_markdown TEXT NOT NULL,
  content_html TEXT,
  file_path TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE trade_plans (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  plan_date TEXT NOT NULL,
  stock_code TEXT,
  stock_name TEXT,
  plan_type TEXT,
  trigger_condition TEXT,
  action_plan TEXT,
  invalid_condition TEXT,
  notes TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE review_logs (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  review_date TEXT NOT NULL,
  stock_code TEXT,
  stock_name TEXT,
  planned_action TEXT,
  actual_action TEXT,
  discipline_result TEXT,
  mistake_type TEXT,
  lesson TEXT,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
