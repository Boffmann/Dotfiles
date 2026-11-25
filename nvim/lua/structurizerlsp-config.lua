vim.lsp.config("structurizr", {
	cmd = { "/Users/tjabben/repos/structurizr-lsp/structurizr-lsp" },
	filetypes = { "structurizr" },
	root_markers = { "workspace.dsl" },
})
vim.lsp.enable("structurizr")

-- K (hover), grr (references), gri (implementation), grn, gra are Neovim built-ins.
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufopts = { silent = true, buffer = args.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	end,
})
