-- -*- mode:lua-ts; -*-
-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
config.font = wezterm.font("Cascadia Code")
config.initial_rows = 43

local act = wezterm.action

config.keys = {
    -- Rebind OPT-Left, OPT-Right as ALT-b, ALT-f to match Terminal.app
    {
        key = "LeftArrow",
        mods = "OPT",
        action = act.SendKey({ key = "b", mods = "ALT" }),
    },
    {
        key = "RightArrow",
        mods = "OPT",
        action = act.SendKey({ key = "f", mods = "ALT" }),
    },
    -- disable some undocumented resize commands
    { key = "-", mods = "CTRL", action = act.DisableDefaultAssignment },
    { key = "_", mods = "CTRL", action = act.DisableDefaultAssignment },
    { key = "-", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
    { key = "_", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
    { key = "+", mods = "CTRL", action = act.DisableDefaultAssignment },
    { key = "=", mods = "CTRL", action = act.DisableDefaultAssignment },
    { key = "+", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
    { key = "=", mods = "SHIFT|CTRL", action = act.DisableDefaultAssignment },
    -- disable full-screen toggle
    -- wezterm show-keys --lua | grep FullScreen
    { key = 'Enter', mods = 'ALT', action = act.DisableDefaultAssignment },
}

-- and finally, return the configuration to wezterm
return config
