---
name: "stock-analysis"
description: "Generates comprehensive stock analysis reports with data fetching, AI analysis, and HTML visualization. Invoke when user asks for stock analysis, stock report, or stock research for any ticker symbol."
---

# Stock Analysis Skill

Generate professional, visually stunning stock analysis reports in HTML format.

## Overview

This skill produces a complete stock analysis report through a 3-phase pipeline:
- **Phase 1**: Data Collection (Python script fetches real market data)
- **Phase 2**: AI Analysis (LLM generates investment insights)
- **Phase 3**: HTML Report (Hand-crafted single-file HTML with CSS/JS)

## Workflow

### Step 0: Environment Setup

Before first use, install dependencies:
```bash
pip install yfinance pandas numpy
```

### Step 1: Data Collection

Run the Phase 1 data collection script located at `.trae/skills/stock-analysis/stock_full_report.py`:

```bash
python .trae/skills/stock-analysis/stock_full_report.py <TICKER>
```

This script will:
1. Fetch 5 years of daily OHLCV data via yfinance
2. Calculate technical indicators (SMA, EMA, RSI, MACD, Bollinger Bands, ATR, OBV, ADX)
3. Fetch financial statements (income, balance sheet, cash flow)
4. Fetch company info, analyst recommendations, institutional holders
5. Output a structured JSON file: `<TICKER>_full_report.json`

**IMPORTANT**: If the Python script fails or yfinance is unavailable, use WebSearch to gather stock data manually. Search for:
- Current stock price and 52-week range
- Key financial metrics (P/E, EPS, Revenue, Net Income)
- Recent news and analyst ratings
- Technical indicators from financial websites

### Step 2: AI Analysis Framework

Read the JSON data from Phase 1, then perform deep analysis following this framework:

#### 2.1 Executive Summary
- One-paragraph investment thesis
- Current price, target price, and recommendation (Strong Buy / Buy / Hold / Sell / Strong Sell)
- Key catalysts and risks in bullet points

#### 2.2 Company Overview
- Business model, revenue segments, competitive positioning
- Industry trends and macro environment

#### 2.3 Financial Analysis
- Revenue growth trajectory (3-5 year trend)
- Profitability analysis (gross margin, operating margin, net margin trends)
- Balance sheet health (debt-to-equity, current ratio, cash position)
- Cash flow quality (operating CF vs net income, free cash flow trend)

#### 2.4 Valuation Analysis
- Relative valuation (P/E, P/S, P/B, EV/EBITDA vs peers and historical)
- DCF assumptions and fair value range
- Analyst consensus targets

#### 2.5 Technical Analysis
- Trend identification (short/medium/long-term)
- Key support/resistance levels
- Momentum indicators (RSI, MACD) interpretation
- Volume analysis and confirmation

#### 2.6 Risk Assessment
- Systematic risks (market, interest rate, currency)
- Unsystematic risks (competitive, regulatory, operational)
- Key risk factors ranked by impact

#### 2.7 Catalysts & Outlook
- Near-term catalysts (earnings, product launches, regulatory)
- Long-term growth drivers
- Consensus vs contrarian views

#### 2.8 Investment Recommendation
- Clear BUY/HOLD/SELL recommendation
- Entry price, target price, stop-loss
- Position sizing suggestion
- Time horizon

### Step 3: HTML Report Generation

Generate a single-file HTML report with ALL CSS and JS inline. Follow these strict rules:

#### HTML Generation Rules

1. **Single File**: All CSS, JS, and content in ONE .html file. No external dependencies except CDN fonts/icons.
2. **No External Images**: Use CSS gradients, SVG icons, and Unicode symbols only. No `<img>` tags.
3. **Professional Design**: Dark theme with accent colors. Use CSS Grid/Flexbox for layout.
4. **Interactive Charts**: Use inline SVG or Canvas for price charts and technical indicators.
5. **Responsive**: Must work on desktop and mobile.
6. **Chart Library**: Use Chart.js via CDN for interactive charts.
7. **Color Palette**:
   - Background: `#0f1419` (main), `#1a2332` (cards)
   - Text: `#e7e9ea` (primary), `#8899a6` (secondary)
   - Accent: `#1d9bf0` (blue), `#00ba7c` (green/up), `#f4212e` (red/down)
   - Border: `#2f3336`

#### HTML Structure Template

```html
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[TICKER] Stock Analysis Report</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Reference: .trae/skills/stock-analysis/shared/template_base.css */
        /* Include all styles inline */
    </style>
</head>
<body>
    <!-- Header with stock name, price, change -->
    <!-- Navigation tabs -->
    <!-- Executive Summary section -->
    <!-- Financial Analysis section with charts -->
    <!-- Technical Analysis section with price chart -->
    <!-- Valuation section -->
    <!-- Risk Assessment section -->
    <!-- Recommendation section -->
    <script>
        /* Chart.js initialization and interactivity */
    </script>
</body>
</html>
```

#### Required Chart Types
1. **Price Chart**: Candlestick-style line chart with volume overlay (5-year daily data)
2. **Revenue/Income Chart**: Bar chart with trend line
3. **Margin Analysis**: Multi-line chart (gross, operating, net margins)
4. **Technical Indicators**: RSI and MACD sub-charts below price chart
5. **Valuation Comparison**: Radar or bar chart comparing P/E, P/S, P/B vs sector

#### Report Sections (Tab-based Navigation)
- **Overview**: Executive summary, key metrics, recommendation badge
- **Financials**: Revenue, income, margins, balance sheet, cash flow
- **Technical**: Price chart with indicators, support/resistance levels
- **Valuation**: Relative valuation, DCF summary, analyst targets
- **Risk & Outlook**: Risk matrix, catalysts, investment thesis

### Step 4: Save & Present

1. Save the HTML file to the user's working directory as `<TICKER>_analysis_report.html`
2. Provide a brief summary of the analysis findings
3. Mention the file location for the user to open in a browser

## File Reference

The skill directory (`.trae/skills/stock-analysis/`) contains:
- `stock_full_report.py` — Phase 1 data collection script
- `src/` — Python modules (data_fetcher, analyzer, utils, html_renderer)
- `shared/template_base.css` — CSS template reference
- `examples/` — Example HTML reports for style reference
- `分析框架.md` — Detailed analysis framework (Chinese)
- `HTML手写参考.md` — HTML hand-crafting guidelines (Chinese)

## Important Constraints

1. **Data Accuracy**: Always use real market data. If yfinance fails, use WebSearch as fallback.
2. **No Fabrication**: Never invent financial data. If data is unavailable, clearly state "N/A" or "Data unavailable".
3. **Disclaimer**: Always include investment disclaimer at the bottom of the report.
4. **Language**: Default to Chinese (zh-CN) for report content unless user specifies otherwise.
5. **Professional Quality**: The HTML report must be visually impressive — dark theme, smooth animations, interactive charts.
6. **Self-Contained**: The HTML file must work offline after initial load (all data embedded, only CDN for Chart.js).
