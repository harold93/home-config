-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

if vim.g.neovide then
  -- Helper function for transparency formatting
  local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.9))
  end
  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  vim.g.neovide_transparency = 1
  -- vim.g.transparency = 0.8
  -- vim.g.neovide_background_color = "#0e2a35" .. alpha()

  vim.g.neovide_no_idle = true
  -- vim.g.neovide_fullscreen = true
  vim.g.neovide_scale_factor = 0.9
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

vim.g.autoformat = true

vim.opt.winbar = "%=%m %f"
