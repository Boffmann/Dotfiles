-- Show diagnostics as virtual text only on the cursor line
vim.diagnostic.config({
	virtual_text = { current_line = true },
})

-- Neovim 0.12 sends textDocument/diagnostic for a server-initiated refresh even while the
-- client is shutting down; rust-analyzer then errors with "Shutdown already requested" on :wq.
local diag_refresh = vim.lsp.handlers["workspace/diagnostic/refresh"]
vim.lsp.handlers["workspace/diagnostic/refresh"] = function(err, res, ctx)
	local client = vim.lsp.get_client_by_id(ctx.client_id)
	if client and client:is_stopped() then
		return vim.NIL
	end
	return diag_refresh(err, res, ctx)
end

-- Advertise nvim-cmp completion capabilities to every server
vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

-- Mason setup; mason-lspconfig v2 auto-enables installed servers via vim.lsp.enable
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"clangd",
	},
})
vim.lsp.enable("rust_analyzer")
-- Autocompletion setup
local cmp = require("cmp")

cmp.setup({
	sources = {
		{
			name = "nvim_lsp",
		},
		{
			name = "path",
		},
	},
	snippet = {
		expand = function(args)
			-- You need Neovim v0.10 to use vim.snippet
			vim.snippet.expand(args.body)
		end,
	},
	-- mapping = cmp.mapping.preset.insert({}),
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
})

-- To get rid of warning "Undefined global vim" in lua vim configs
vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
		},
	},
})
vim.lsp.enable({ "lua_ls" })

vim.lsp.config("pylsp", {
	settings = {
		pylsp = {
			plugins = {
				pycodestyle = {
					maxLineLength = 120,
				},
			},
		},
	},
})
vim.lsp.enable({ "pylsp" })
