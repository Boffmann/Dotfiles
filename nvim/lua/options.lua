local opt = vim.opt


--opt.autowrite = true -- Enable auto write
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 3           -- Hide * markup for bold and italic
opt.confirm = false            -- Confirm to save changes before exiting modified buffer
opt.cursorline = true          -- Enable highlighting of the current line
opt.expandtab = true           -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true      -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.incsearch = true
opt.laststatus = 0
opt.list = true           -- Show some invisible characters (tabs...
opt.mouse = ""            -- Enable mouse mode
opt.number = true         -- Print line number
opt.pumblend = 10         -- Popup blend
opt.pumheight = 10        -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
-- opt.statuscolumn = "%l %r"
opt.scrolloff = 5         -- Lines of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true     -- Round indent
opt.shiftwidth = 4        -- Size of an indent
opt.shortmess:append { W = true, I = true, c = true }
opt.showmode = false      -- Dont show mode since we have a statusline
opt.sidescrolloff = 8     -- Columns of context
opt.signcolumn = "yes"    -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true      -- Don't ignore case with capitals
opt.smartindent = true    -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true     -- Put new windows below current
opt.splitright = true     -- Put new windows right of current
opt.tabstop = 4           -- Number of spaces tabs count for
opt.termguicolors = true  -- True color support
opt.timeoutlen = 150
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200               -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5                -- Minimum window width
opt.wrap = false                   -- Disable line wrap

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0


vim.cmd([[
:autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
:highlight ExtraWhitespace ctermbg=red guibg=red " Create Highlight Group
:match ExtraWhitespace /\s\+$/ " Show trailing whitespace
:au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/ " Show ExtraWhitespace as soon as leaving insert mode
:au InsertLeave * match ExtraWhitespace /\s\+$/
]])

-- vim.g.copilot_no_virtual_text = true
-- vim.g.copilot_no_tab_map = true
-- vim.g.copilot_no_preview = true
-- vim.g.copilot_assume_mapped = true

-- For ZelliJ
vim.api.nvim_create_autocmd("VimLeave", {
    pattern = "*",
    command = "silent !zellij action switch-mode locked"
})
