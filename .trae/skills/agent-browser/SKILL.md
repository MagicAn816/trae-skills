---
name: "agent-browser"
description: "Browser automation CLI for AI agents. Use when the user needs to interact with websites, navigate pages, fill forms, click buttons, take screenshots, extract data, test web apps, or automate any browser task. Also use for Electron desktop apps automation."
---

# agent-browser

Fast browser automation CLI for AI agents. Chrome/Chromium via CDP with
accessibility-tree snapshots and compact `@eN` element refs.

## Installation & Setup

Already installed globally via npm. Chrome browser is at:
`C:\Users\azy81\.agent-browser\browsers\chrome-147.0.7727.57\chrome.exe`

If Chrome needs updating, run:
```bash
agent-browser install
```

**IMPORTANT**: Due to PowerShell execution policy restrictions, always prefix
agent-browser commands with:
```bash
powershell -ExecutionPolicy Bypass -Command "agent-browser <command>"
```

Or use npx:
```bash
npx agent-browser <command>
```

## Core Workflow

### 1. Open a page
```bash
agent-browser open https://example.com
```

### 2. Get accessibility snapshot (best for AI)
```bash
agent-browser snapshot
```
Returns an accessibility tree with `@eN` element refs for reliable interaction.

### 3. Interact with elements
```bash
agent-browser click @e2          # Click by ref
agent-browser fill @e3 "text"    # Fill input by ref
agent-browser type @e4 "hello"   # Type into element
agent-browser press Enter        # Press key
agent-browser scroll down 500    # Scroll page
```

### 4. Extract information
```bash
agent-browser get text @e1       # Get text content
agent-browser get html @e1       # Get innerHTML
agent-browser get url            # Get current URL
agent-browser get title          # Get page title
agent-browser screenshot page.png  # Take screenshot
```

### 5. Close when done
```bash
agent-browser close
```

## Command Reference

### Navigation & Page
| Command | Description |
|---------|-------------|
| `agent-browser open <url>` | Launch browser + navigate |
| `agent-browser goto <url>` | Navigate to URL |
| `agent-browser back` | Go back |
| `agent-browser forward` | Go forward |
| `agent-browser reload` | Reload page |

### Element Interaction
| Command | Description |
|---------|-------------|
| `agent-browser click <sel>` | Click element |
| `agent-browser dblclick <sel>` | Double-click |
| `agent-browser fill <sel> <text>` | Clear + fill input |
| `agent-browser type <sel> <text>` | Type into element |
| `agent-browser press <key>` | Press key (Enter, Tab, etc.) |
| `agent-browser hover <sel>` | Hover element |
| `agent-browser select <sel> <val>` | Select dropdown |
| `agent-browser check <sel>` | Check checkbox |
| `agent-browser uncheck <sel>` | Uncheck checkbox |
| `agent-browser scroll <dir> [px]` | Scroll (up/down/left/right) |
| `agent-browser upload <sel> <files>` | Upload files |
| `agent-browser drag <src> <tgt>` | Drag and drop |

### Information Extraction
| Command | Description |
|---------|-------------|
| `agent-browser snapshot` | Accessibility tree with refs |
| `agent-browser get text <sel>` | Get text content |
| `agent-browser get html <sel>` | Get innerHTML |
| `agent-browser get value <sel>` | Get input value |
| `agent-browser get attr <sel> <attr>` | Get attribute |
| `agent-browser get url` | Get current URL |
| `agent-browser get title` | Get page title |
| `agent-browser screenshot [path]` | Take screenshot |
| `agent-browser screenshot --annotate` | Screenshot with numbered labels |
| `agent-browser screenshot --full` | Full page screenshot |
| `agent-browser pdf <path>` | Save as PDF |

### Semantic Element Finding
| Command | Description |
|---------|-------------|
| `agent-browser find role <role> <action> [value]` | By ARIA role |
| `agent-browser find text <text> <action>` | By text content |
| `agent-browser find label <label> <action> [value]` | By label |
| `agent-browser find placeholder <ph> <action>` | By placeholder |
| `agent-browser find testid <id> <action> [value]` | By data-testid |

### Waiting
| Command | Description |
|---------|-------------|
| `agent-browser wait <selector>` | Wait for element visible |
| `agent-browser wait <ms>` | Wait milliseconds |
| `agent-browser wait --text "Welcome"` | Wait for text |
| `agent-browser wait --url "**/dash"` | Wait for URL pattern |
| `agent-browser wait --load networkidle` | Wait for load state |

### Tabs & Windows
| Command | Description |
|---------|-------------|
| `agent-browser tab` | List tabs |
| `agent-browser tab new [url]` | New tab |
| `agent-browser tab <tN>` | Switch to tab |
| `agent-browser tab close [tN]` | Close tab |
| `agent-browser window new` | New window |

### Network
| Command | Description |
|---------|-------------|
| `agent-browser network requests` | View tracked requests |
| `agent-browser network har start` | Start HAR recording |
| `agent-browser network har stop` | Stop and save HAR |
| `agent-browser network route <url>` | Intercept requests |

### Cookies & Storage
| Command | Description |
|---------|-------------|
| `agent-browser cookies` | Get all cookies |
| `agent-browser cookies set <name> <val>` | Set cookie |
| `agent-browser cookies clear` | Clear cookies |
| `agent-browser storage local` | Get localStorage |

### Batch Execution
Execute multiple commands in one invocation (avoids per-command startup overhead):
```bash
agent-browser batch "open https://example.com" "snapshot -i" "screenshot"
```

Or pipe JSON via stdin:
```bash
echo '[["open","https://example.com"],["snapshot","-i"],["click","@e1"]]' | agent-browser batch --json
```

### JavaScript Evaluation
```bash
agent-browser eval "document.title"
agent-browser eval "JSON.stringify({url: location.href, title: document.title})"
```

## Common Patterns

### Web Scraping
```bash
agent-browser open https://example.com
agent-browser snapshot
# Identify elements from snapshot, then extract:
agent-browser get text @e5
agent-browser close
```

### Form Filling
```bash
agent-browser open https://example.com/form
agent-browser fill @e1 "John Doe"
agent-browser fill @e2 "john@example.com"
agent-browser find role button click --name "Submit"
agent-browser wait --load networkidle
agent-browser snapshot
```

### Login Flow
```bash
agent-browser open https://example.com/login
agent-browser fill @e1 "username"
agent-browser fill @e2 "password"
agent-browser click @e3
agent-browser wait --load networkidle
agent-browser snapshot
```

### Multi-tab Research
```bash
agent-browser open https://site1.com
agent-browser tab new --label research https://site2.com
agent-browser tab research
agent-browser snapshot
agent-browser tab t1
agent-browser snapshot
```

### Screenshot Comparison
```bash
agent-browser open https://example.com
agent-browser screenshot before.png
agent-browser click @e1
agent-browser wait --load networkidle
agent-browser screenshot after.png
```

## Specialized Skills

Load specialized skills for advanced use cases:
```bash
agent-browser skills get core       # Core workflows & troubleshooting
agent-browser skills get core --full # Full command reference & templates
agent-browser skills get electron   # Electron desktop apps (VS Code, Slack, etc.)
agent-browser skills get slack      # Slack workspace automation
agent-browser skills get dogfood    # Exploratory testing / QA
agent-browser skills list           # List all available skills
```

## Troubleshooting

### PowerShell Execution Policy Error
If you see "禁止运行脚本" error, use:
```bash
powershell -ExecutionPolicy Bypass -Command "agent-browser <command>"
```

### Chrome Not Found
Run `agent-browser install` to download Chrome for Testing.

### Session Issues
```bash
agent-browser close --all   # Close all sessions
agent-browser close         # Close current session
```

### Dashboard
The observability dashboard runs on port 4848:
```
https://dashboard.agent-browser.localhost
```

## Key Advantages
- Fast native Rust CLI (not a Node.js wrapper)
- Chrome/Chromium via CDP (no Playwright/Puppeteer dependency)
- Accessibility-tree snapshots with `@eN` refs for reliable AI interaction
- Sessions, authentication vault, state persistence, video recording
- Works with any AI agent (Cursor, Claude Code, Codex, Trae, etc.)
