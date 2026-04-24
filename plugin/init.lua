-- wez_status_bar_alert.lua

local M = {}

local wezterm = require("wezterm")

local state = {
  message = "",
  timeout = 2,
}

function M.notify(msg, opts)
  opts = opts or {}
  state.message = msg

  local timeout = opts.timeout or state.timeout

  wezterm.time.call_after(timeout, function()
    state.message = ""
  end)
end

function M.component()
  return function()
    if state.message == "" then
      return ""
    end

    return wezterm.format({
      { Attribute = { Intensity = "Bold" } },
      { Foreground = { AnsiColor = "Fuchsia" } },
      { Background = { Color = "#2b2042" } },
      { Text = "  󱐋 " .. state.message .. "  " },
      "ResetAttributes",
    })
  end
end

return M
