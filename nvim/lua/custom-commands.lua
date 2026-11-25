local autocmd_group = vim.api.nvim_create_augroup(
    "LspFormatting",
    {clear = true})

function GoFmt()
    local saved_view = vim.fn.winsaveview()
    -- vim.cmd('silent %!gofmt')
    -- local ok, result = vim.api.nvim_exec('silent %!gofmt', true)
    local ok, _ = pcall(vim.cmd, 'silent %!/Users/tjabben/go/bin/goimports')
    if not ok then
        vim.cmd('silent undo')
    end
    vim.fn.winrestview(saved_view)
end

vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = '*.go',
    callback = GoFmt,
    group = autocmd_group,
})

vim.api.nvim_create_autocmd({'BufWritePre'}, {
    group = autocmd_group,
    callback = function(args)
        vim.lsp.buf.format({
            bufnr = args.buf,
            -- rustfmt via rust-analyzer; dprint has no config for Rust files
            filter = function(client)
                return not (client.name == "dprint" and vim.bo[args.buf].filetype == "rust")
            end,
        })
    end,
})
