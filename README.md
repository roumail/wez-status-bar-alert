# wez-status-bar-alert

A WezTerm plugin for displaying temporary status bar notifications. Just say what you must.

## Installation

```lua
local wezterm = require("wezterm")
local config = wezterm.config_builder()

local wez_sb_alert = wezterm.plugin.require("https://github.com/roumail/wez-status-bar-alert")
```

## Usage

### Register notifications

Call `notify` from any WezTerm event handler:

```lua
-- Show a message when the config is reloaded
wezterm.on("window-config-reloaded", function(window, pane)
  wez_sb_alert.notify("Config reloaded")
end)

-- Show a message when a new tab is created
wezterm.on("tab-title-changed", function(tab, pane, window, event, fallback)
  wez_sb_alert.notify("Tab: " .. tab:get_title(), { timeout = 1.5 })
end)
```

### Wire the component into your status bar

Pass `component()` as a tabline section. Works with [tabline.wez](https://github.com/michaelbrusegard/tabline.wez):

```lua
local status_sections = {
  tabline_x = {
    wez_sb_alert.component(),
  },
  tabline_y = {},
  tabline_z = { "datetime" },
}

tabline.setup({ sections = status_sections })
tabline.apply_to_config(config)
```

## API

### `notify(msg, opts?)`

Displays `msg` in the status bar for a short duration, then clears it automatically.

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `timeout` | number | `2` | Seconds before the message is cleared |

### `component()`

Returns a tabline-compatible render function that displays the current message. Pass the return value directly as a section entry — do not call it yourself.
