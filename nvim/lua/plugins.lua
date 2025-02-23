return {
    -- Gruvbox Color Scheme
    {
        "ellisonleao/gruvbox.nvim"
    },
    { -- Highlight focussed pane
        'levouh/tint.nvim',
    },
    -- Lualine (THE NEW EXTENSION ADDED IN CONFIGURATION)
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'echasnovski/mini.icons',
            'nvim-lua/plenary.nvim'
        },
    },
    {
        "goolord/alpha-nvim",
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },
    {
        "karb94/neoscroll.nvim",
    },
    {
        "tpope/vim-commentary"
    },
    {
        "ggandor/leap.nvim",
        dependencies = {
            { 'tpope/vim-repeat' },
        },
    },
    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        }
    },
    { -- LSP Support
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'hrsh7th/nvim-cmp',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    {
        "jay-babu/mason-null-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "nvimtools/none-ls.nvim",
        },
    },
    {
        "akinsho/bufferline.nvim"
    },
    { -- Aerial (Outline whindow e.g. for showing methods in file)
        'stevearc/aerial.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
    },
    { -- Display marks
        "kshenoy/vim-signature"
    },
    -- Nvim DAP (Debuging)
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "nvim-neotest/nvim-nio"
        }
    },
    {
        'mfussenegger/nvim-dap',
        recommended = true,
        desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

        dependencies = {
            "rcarriga/nvim-dap-ui",
            -- virtual text for the debugger
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = {},
            },
        },
    },
    {
        "leoluz/nvim-dap-go"
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "alfaix/neotest-gtest"
        }
    },
    -- Nvimtree (File Explorer)
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },
    -- Telescope (Fuzzy Finder)
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
        }
    },
    -- Toggle Term
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        config = true,
    },
    -- Navigator for Zellij
    {
        "swaits/zellij-nav.nvim",
        lazy = true,
        event = "VeryLazy",
        keys = {
            { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { silent = true, desc = "navigate left or tab" } },
            { "<c-j>", "<cmd>ZellijNavigateDown<cr>",     { silent = true, desc = "navigate down" } },
            { "<c-k>", "<cmd>ZellijNavigateUp<cr>",       { silent = true, desc = "navigate up" } },
            { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
        },
        opts = {},
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" },                       -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken",                            -- Only on MacOS or Linux
        opts = {
            copilot_no_virtual_text = true,
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
    },
    -- WhichKey (Key Binding extension)
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        dependencies = {
            { 'echasnovski/mini.icons' },
        }
    },
}
