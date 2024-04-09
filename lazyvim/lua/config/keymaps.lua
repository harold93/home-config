-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
local discipline = require("lib.cowboy")

discipline.cowboy()

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "center when scrolling" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "center when scrolling" })
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "keep content in register after paste" })

-- silly remap lol
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "remap of escape" })

-- auto save toggle
vim.keymap.set("n", "<leader>n", ":ASToggle<CR>", { desc = "tootle auto save" })
-- undotree toogle
vim.keymap.set("n", "<leader>*", vim.cmd.UndotreeToggle, { desc = "toogle undo tree" })

-- for mac compatibility
vim.keymap.set("n", "∆", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("n", "˚", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv", { desc = "move line down" })
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv", { desc = "move line up" })
