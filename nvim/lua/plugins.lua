return {
    -- Gruvbox Color Scheme
    {
        "ellisonleao/gruvbox.nvim"
    },
    -- Lualine (THE NEW EXTENSION ADDED IN CONFIGURATION)
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons' 
        },
    },
    {
        "karb94/neoscroll.nvim",
    },
    {
        "tpope/vim-commentary"
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
    -- Language Support
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    },
    {
        "kshenoy/vim-signature"
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
            {'nvim-lua/plenary.nvim'},
        }
    },
    -- Toggle Term
    {
        'akinsho/toggleterm.nvim',
        tag = "*",
        config = true
    },
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
    },
    -- WhichKey (Key Binding extension)
    {
        "folke/which-key.nvim",
        lazy = true,
    },
}
