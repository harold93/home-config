vim.g.mapleader = " "

vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")

-- space instead of tabs
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set smartindent")
vim.cmd("set cindent")

vim.cmd("set scrolloff=5")
-- For mac true color
vim.cmd("set termguicolors")

-- Change default split to right and bottom
vim.cmd("set splitbelow")
vim.cmd("set splitright")

-- Ignore case when searching
vim.cmd("set ignorecase")
vim.cmd("set smartcase")

-- Nvim opt
-- vim.opt.winbar = "%=%m %f" -- Commenting because clashing with lspsaga breadcrum
-- vim.opt.signcolumn = 'yes:2'

-- Enable 24-bit colorcolor
vim.opt.termguicolors = true

-- Personal Keymaps
-- ****************
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "go to the begining of the line" })
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "go to the begining of the line" })
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "keep content in register after paste" })
-- silly remap lol
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "remap of escape" })

vim.keymap.set("n", "Q", "@q", { desc = "Q => @q" })
vim.keymap.set("x", "Q", ":norm @q<CR>", { desc = "selector mode Q => @q<CR>" })

-- Commenting because of vim-tmux-navigator
-- vim.keymap.set('n', '<C-h>', '<C-w>h', {desc = 'move between windows' })
-- vim.keymap.set('n', '<C-j>', '<C-w>j', {desc = 'move between windows' })
-- vim.keymap.set('n', '<C-k>', '<C-w>k', {desc = 'move between windows' })
-- vim.keymap.set('n', '<C-l>', '<C-w>l', {desc = 'move between windows' })

vim.keymap.set("n", "<leader>tt", ":tabnew<CR>", { desc = "open new tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "close new tab" })
vim.keymap.set("n", "<leader>tn", ":tabp<CR>", { desc = "go to prev tab" })
vim.keymap.set("n", "<leader>tp", ":tabn<CR>", { desc = "go to next tab" })

-- Move selected lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "move line down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "move line up" })
-- And mac compatibility
vim.keymap.set("n", "∆", ":m .+1<CR>==", { desc = "move line down" })
vim.keymap.set("n", "˚", ":m .-2<CR>==", { desc = "move line up" })
vim.keymap.set("v", "∆", ":m '>+1<CR>gv=gv", { desc = "move line down" })
vim.keymap.set("v", "˚", ":m '<-2<CR>gv=gv", { desc = "move line up" })

-- Open explorer
vim.keymap.set("n", "<leader>e", ":Ex<CR>", { desc = "open explorer page" })

-- scroll
vim.keymap.set("n", "<C-d>", "25<C-d>", { desc = "scroll down reduced" })
vim.keymap.set("n", "<C-u>", "25<C-u>", { desc = "scroll up reduced" })

-- neovide config
if vim.g.neovide then
	vim.g.neovide_transparency = 0.9
	vim.g.neovide_window_blurred = true
	vim.g.neovide_input_macos_alt_is_meta = true
	vim.g.neovide_profiler = false
end
