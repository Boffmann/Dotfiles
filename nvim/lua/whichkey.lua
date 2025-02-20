-- if not status_ok then
--     return
-- end

-- Use Telescope GUI for Harpoon
local harpoon = require("harpoon")
local conf = require("telescope.config").values

function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

-- End Use Telescope GUI for Harpoon

local setup = {
    plugins = {
        marks = true,         -- shows a list of your marks on ' and `
        registers = true,     -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false,   -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true,      -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true,      -- default bindings on <c-w>
            nav = true,          -- misc bindings to work with windows
            z = true,            -- bindings for folds, spelling and others prefixed with z
            g = true,            -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    win = {
        border = "rounded", -- none, single, double, shadow
        padding = { 1, 1 }, -- extra window padding [top, right, bottom, left]
        wo = {
            winblend = 0,
        }
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3,                    -- spacing between columns
        align = "left",                 -- align columns left, center or right
    },
    filter = function(mapping)
        -- enable this to hide mappings for which you didn't specify a label
        -- example to exclude mappings without a description
        -- return mapping.desc and mapping.desc ~= ""
        return true
    end,
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = {
        { "<auto>", mode = "nxso" },
    },
}

local opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
}

local wk = require("which-key")
wk.setup(setup)
wk.add({
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Explorer",      nowait = true, remap = false },
    { "<leader>q", "<cmd>bdelete<CR>",        desc = "Kill Buffer",   nowait = true, remap = false },
    { "<leader>o", "<cmd>AerialToggle!<cr>",  desc = "Toggle Aerial", nowait = true, remap = false },
}, { mode = "n" })
wk.add({
    { "<leader>a",  group = "Arrangements", nowait = true,              remap = false },
    { "<leader>af", "<cmd>tabfirst<CR>",    desc = "Jump to first Tab", nowait = true, remap = false },
    { "<leader>ag", "tab",                  desc = "Jump to last Tab",  nowait = true, remap = false },
    { "<leader>ah", "<cmd>split<CR>",       desc = "Split Horizontal",  nowait = true, remap = false },
    { "<leader>al", "<cmd>tablast<CR>",     desc = "Jump to last Tab",  nowait = true, remap = false },
    { "<leader>an", "<cmd>tabn<CR>",        desc = "Next Tab",          nowait = true, remap = false },
    { "<leader>ap", "<cmd>tabp<CR>",        desc = "Previous Tab",      nowait = true, remap = false },
    { "<leader>at", "<cmd>tabnew<CR>",      desc = "New Tab",           nowait = true, remap = false },
    { "<leader>av", "<cmd>vsplit<CR>",      desc = "Split Vertical",    nowait = true, remap = false },
}, { mode = "n" })
wk.add({
    { "<leader>f",  group = "File Search",                                    nowait = true,                           remap = false },
    { "<leader>ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "Find files",                     nowait = true, remap = false },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                            desc = "Open Recent File",               nowait = true, remap = false },
    { "<leader>fb", "<cmd>Telescope buffers<cr>",                             desc = "Buffers",                        nowait = true, remap = false },
    { "<leader>fg", "<cmd>Telescope live_grep <cr>",                          desc = "Find Text Pattern In All Files", nowait = true, remap = false },
    { "<leader>fm", "<cmd>Telescope marks<cr>",                               desc = "Marks",                          nowait = true, remap = false },
    { "<leader>fj", "<cmd>Telescope jumplist<cr>",                            desc = "Jumps",                          nowait = true, remap = false },
}, { mode = "n" })
wk.add({
    { "<leader>g",  group = "GoTo",                              nowait = true,              remap = false },
    { "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>",    desc = "To Declaration",    nowait = true, remap = false },
    { "<leader>gK", "<cmd>lua vim.lsp.buf.hover()<CR>",          desc = "Hover",             nowait = true, remap = false },
    { "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>",     desc = "To Definition",     nowait = true, remap = false },
    { "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "To Implementation", nowait = true, remap = false },
}, { mode = "n" })
wk.add({
    { "<leader>h",  group = "Harpoon",                                                                 nowait = true,       remap = false },
    { "<leader>ha", "<cmd>lua require('harpoon'):list():add()<cr>",                                    desc = "Add",        nowait = true, remap = false },
    { "<leader>hh", "<cmd>lua toggle_telescope(require('harpoon'):list())<cr>",                        desc = "Finder",     nowait = true, remap = false },
    { "<leader>hm", "<cmd>lua require('harpoon').ui:toggle_quick_menu(require('harpoon'):list())<cr>", desc = "Quick Menu", nowait = true, remap = false },
    { "<leader>hn", "<cmd>lua require('harpoon'):list():next()<cr>",                                   desc = "Next",       nowait = true, remap = false },
    { "<leader>hp", "<cmd>lua require('harpoon'):list():prev()<cr>",                                   desc = "Previous",   nowait = true, remap = false },
}, { mode = "n" })
wk.add({
    { "<leader>l",  group = "LSP",                                      nowait = true,              remap = false },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols", nowait = true, remap = false },
    { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>",           desc = "Code Action",       nowait = true, remap = false },
    { "<leader>lf", "<cmd>lua vim.lsp.buf.format{async=true}<cr>",      desc = "Reformat Code",     nowait = true, remap = false },
    { "<leader>li", "<cmd>LspInfo<cr>",                                 desc = "Info",              nowait = true, remap = false },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>",              desc = "CodeLens Action",   nowait = true, remap = false },
    { "<leader>lm", "<cmd>Mason<cr>",                                   desc = "Mason UI for Lsp",  nowait = true, remap = false },
    { "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",                desc = "Rename",            nowait = true, remap = false },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",          desc = "Document Symbols",  nowait = true, remap = false },
}, { mode = "n" })
wk.add({
    { "<leader>s",  group = "Search",               nowait = true,      remap = false },
    { "<leader>sc", "<cmd>Telescope commands<cr>",  desc = "Commands",  nowait = true, remap = false },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",   desc = "Keymaps",   nowait = true, remap = false },
    { "<leader>sm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
    { "<leader>sr", "<cmd>Telescope registers<cr>", desc = "Registers", nowait = true, remap = false },
}, { mode = "n" })
wk.add({
    { "<leader>t",  group = "Terminal",                                 nowait = true,       remap = false },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",              desc = "Float",      nowait = true, remap = false },
    { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal", nowait = true, remap = false },
    { "<leader>tn", "<cmd>lua _NODE_TOGGLE()<cr>",                      desc = "Node",       nowait = true, remap = false },
    { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>",                    desc = "Python",     nowait = true, remap = false },
    { "<leader>tt", "<cmd>lua _HTOP_TOGGLE()<cr>",                      desc = "Htop",       nowait = true, remap = false },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",   desc = "Vertical",   nowait = true, remap = false },
}, { mode = "n" })
wk.add({
    { "<leader>d",      group = "Debugger",                                                                   nowait = true,                   remap = false },
    { "<leader>d<F5>",  function() require("dap").continue() end,                                             desc = "Run/Continue" },
    { "<leader>d<F6>",  function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
    { "<leader>d<F10>", function() require("dap").step_over() end,                                            desc = "Step Over" },
    { "<leader>d<F11>", function() require("dap").step_into() end,                                            desc = "Step Into" },
    { "<leader>d<F12>", function() require("dap").step_out() end,                                             desc = "Step Out" },
    { "<leader>db",     function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
    { "<leader>dB",     function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>dC",     function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
    { "<leader>dg",     function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
    { "<leader>dj",     function() require("dap").down() end,                                                 desc = "Down" },
    { "<leader>dk",     function() require("dap").up() end,                                                   desc = "Up" },
    { "<leader>dl",     function() require("dap").run_last() end,                                             desc = "Run Last" },
    { "<leader>dP",     function() require("dap").pause() end,                                                desc = "Pause" },
    { "<leader>dr",     function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
    { "<leader>ds",     function() require("dap").session() end,                                              desc = "Session" },
    { "<leader>dt",     function() require("dap").terminate() end,                                            desc = "Terminate" },
    { "<leader>dw",     function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    { "<leader>du",     function() require("dapui").open() end,                                               desc = "Open UI" },
    { "<leader>dU",     function() require("dapui").close() end,                                              desc = "Close UI" },
    { "<leader>dz",     function() require("dapui").toggle() end,                                             desc = "Toggle UI" },
    { "<leader>dT",     function() require("neotest").summary.open() end,                                     desc = "Open Neotest Summary" },
}, { mode = "n" })
wk.add({
    { "<leader>C",  group = "Github Copilot",     nowait = true,               remap = false },
    { "<leader>Cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Chat" },
    { "<leader>Cq", "<cmd>CopilotChatClose<cr>",  desc = "Close Chat" },
    { "<leader>Ct", "<cmd>CopilotChatOpen<cr>",   desc = "Open Chat" },
    { "<leader>Cr", "<cmd>CopilotChatReset<cr>",  desc = "Reset Chat" },
    { "<leader>Cs", "<cmd>CopilotChatStop<cr>",   desc = "Stop current output" },
}, { mode = "n" })
