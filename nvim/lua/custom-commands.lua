local group = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

-- Format on save only in buffers with a formatting-capable client (no warning elsewhere).
vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or not client:supports_method("textDocument/formatting") then
			return
		end
		vim.api.nvim_clear_autocmds({ group = group, event = "BufWritePre", buffer = args.buf })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = group,
			buffer = args.buf,
			callback = function()
				if vim.bo[args.buf].filetype == "go" then
					-- goimports equivalent via gopls
					local params = vim.lsp.util.make_range_params(0, "utf-16")
					params.context = { only = { "source.organizeImports" }, diagnostics = {} }
					local res = vim.lsp.buf_request_sync(args.buf, "textDocument/codeAction", params, 1000)
					for cid, r in pairs(res or {}) do
						for _, action in pairs(r.result or {}) do
							if action.edit then
								local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
								vim.lsp.util.apply_workspace_edit(action.edit, enc)
							end
						end
					end
				end
				vim.lsp.buf.format({
					bufnr = args.buf,
					-- rustfmt via rust-analyzer; dprint has no config for Rust files
					filter = function(c)
						return not (c.name == "dprint" and vim.bo[args.buf].filetype == "rust")
					end,
				})
			end,
		})
	end,
})
