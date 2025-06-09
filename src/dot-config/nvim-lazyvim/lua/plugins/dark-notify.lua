return {
  {
    "cormacrelf/dark-notify",
    config = function()
      local dn = require("dark_notify")

      -- mac bin notify
      -- brew install cormacrelf/tap/dark-notify
      -- Configure
      dn.run({
        schemes = {
          dark = "tokyonight-moon",
          light = "catppuccin-latte",
        },
        onchange = function(mode)
          -- optional, you can configure your own things to react to changes.
          -- this is called at startup and every time dark mode is switched,
          -- either via the OS, or because you manually set/toggled the mode.
          -- mode is either "light" or "dark"
        end,
      })
    end,
  },
}
