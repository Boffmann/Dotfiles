-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Set up custom filetypes
vim.filetype.add {
  extension = {
    foo = "fooscript",
  },
  filename = {
    ["Foofile"] = "fooscript",
  },
  pattern = {
    ["~/%.config/foo/.*"] = "fooscript",
  },
}
  --
-- Helper function to find the root directory
local function find_root_dir(startpath, root_files)
  local function is_root(path)
    for _, root_file in ipairs(root_files) do
      if vim.loop.fs_stat(path .. '/' .. root_file) then
        return true
      end
    end
    return false
  end

  local path = startpath
  while path and path ~= '/' do
    if is_root(path) then
      return path
    end
    path = vim.fn.fnamemodify(path, ':h')
  end
  return nil
end

-- Create an event handler for the FileType autocommand
-- TOOD: Set variable
local lspLanguageServerBinaryPath = "/Users/tjabben/repos/structurizr-lsp/structurizr-lsp"
vim.api.nvim_create_autocmd("FileType", {
  pattern = 'structurizr',  -- Adjust this pattern to the specific file types you are targeting
  callback = function(ev)
    local buf_path = vim.fn.expand('%:p:h')
    local root_dir = find_root_dir(buf_path, {'workspace.dsl'})
    if root_dir then
      vim.lsp.start({
        name = 'go-structurizr-lsp',
        cmd = { lspLanguageServerBinaryPath },
        root_dir = root_dir,
      })
    else
      vim.notify("Root directory not found", vim.log.levels.ERROR)
    end
  end,
})


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
  local bufnr = args.buf
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  end,
})
