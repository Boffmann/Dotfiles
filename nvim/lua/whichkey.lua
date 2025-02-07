local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k", "g" },
        v = { "j", "k", "g" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    ["q"] = { "<cmd>bdelete<CR>", "Kill Buffer" },  -- Close current file
    ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" }, -- File explorer

    -- Arrangements
    a = {
        name = "Arrangements",
        t = { "<cmd>tabnew<CR>", "New Tab" },
        n = { "<cmd>tabn<CR>", "Next Tab" },
        p = { "<cmd>tabp<CR>", "Previous Tab" },
        f = { "<cmd>tabfirst<CR>", "Jump to first Tab" },
        l = { "<cmd>tablast<CR>", "Jump to last Tab" },
        g = { "tab", "Jump to last Tab" },
        h = { "<cmd>split<CR>", "Split Horizontal" },
        v = { "<cmd>vsplit<CR>", "Split Vertical" },
    },

    -- GoTo
    g = {
        name = "GoTo",
        D = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "To Declaration" },
        d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "To Definition" },
        i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "To Implementation" },
        K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
        r = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "Telescope References" },
    },

    -- Telescope
    f = {
        name = "File Search",
        -- c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        f = { "<cmd>lua require('telescope.builtin').find_files()<cr>", "Find files" },
        t = { "<cmd>Telescope live_grep <cr>", "Find Text Pattern In All Files" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    },

    s = {
        name = "Search",
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        r = { "<cmd>Telescope registers<cr>", "Registers" },
        j = { "<cmd>Telescope marks<cr>", "Marks" },
        k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        c = { "<cmd>Telescope commands<cr>", "Commands" },
    },

    h = {
        name = "Harpoon",
        a = { "<cmd>lua require('harpoon'):list():append()<cr>", "Append" },
        h = { "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>", "Finder" },
    },

    -- LSP keybindings
    l = {
        name = "LSP",
        m = { "<cmd>Mason<cr>", "Mason UI for Lsp" },
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        i = { "<cmd>LspInfo<cr>", "Info" },
        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Reformat Code" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            "Workspace Symbols",
        },
    },
    --Toggle Term
    t = {
        name = "Terminal",
        n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" }, -- Node Terminal
        t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" }, -- (Optional) Htop, If you have htop in linux
        p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" }, -- Python Terminal
        f = { "<cmd>ToggleTerm direction=float<cr>", "Float" }, -- Floating Terminal

        -- Play with size according to your needs.
        h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" }, -- Horizontal Terminal,
        v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" }, -- Vertical Terminal
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
