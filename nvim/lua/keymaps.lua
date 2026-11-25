local opts = { noremap = true, silent = true }


-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Resize with arrows when using multiple windows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<c-down>", ":resize +2<cr>", opts)
keymap("n", "<c-right>", ":vertical resize -2<cr>", opts)
keymap("n", "<c-left>", ":vertical resize +2<cr>", opts)

-- navigate buffers
keymap("n", "<tab>", ":bnext<cr>", opts) -- Next Tab
keymap("n", "<s-tab>", ":bprevious<cr>", opts) -- Previous tab
keymap("n", "<Esc>", "<cmd>nohlsearch<cr><Esc>", opts) -- No highlight search

-- move text up and down
keymap("n", "<a-j>", "<cmd>m .+1<cr>==", opts) -- Alt-j
keymap("n", "<a-k>", "<cmd>m .-2<cr>==", opts) -- Alt-k

-- Harpoon navigation
-- vim.keymap.set("n", "<C-S-P>", function() require('harpoon'):list():prev() end) -- Toggle previous buffer in Harpoon List (Control - Shift - P)
-- vim.keymap.set("n", "<C-S-N>", function() require('harpoon'):list():next() end) -- Toggle next buffer in Harpoon List (Control - Shift - N)

-- NVimTree
-- keymap("n", "<F5>", "<cmd>NvimTreeToggle<cr>", opts)

-- insert --
-- press jk fast to exit insert mode
keymap("i", "jk", "<esc>", opts) -- Insert mode -> jk -> Normal mode
keymap("i", "kj", "<esc>", opts) -- Insert mode -> kj -> Normal mode

-- visual --
-- stay in indent mode
keymap("v", "<", "<gv", opts) -- Right Indentation
keymap("v", ">", ">gv", opts) -- Left Indentation

-- Visual Block --
-- Move text up and down
--Terminal --
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
