local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("TerminalKeymaps", { clear = true }),
	pattern = "term://*",
	callback = function(ev)
		-- lazygit needs <Esc>, and jk mappings make typing j lag
		if vim.api.nvim_buf_get_name(ev.buf):match(":lazygit") then
			return
		end
		local opts = { buffer = ev.buf }
		vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
		vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
		vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
		vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
	end,
})

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })

function _NODE_TOGGLE()
	node:toggle()
end

local python = Terminal:new({ cmd = "python3", hidden = true })

function _PYTHON_TOGGLE()
	python:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })

function _HTOP_TOGGLE()
	htop:toggle()
end

-- Dedicated floating terminal for cursor-agent
local cursor_agent = Terminal:new({ cmd = "cursor-agent", hidden = true, direction = "float" })

function _CURSOR_AGENT_TOGGLE()
	cursor_agent:toggle()
end

-- Dedicated floating terminal for auggie
local augment_agent = Terminal:new({ cmd = "auggie --model opus4.5", hidden = true, direction = "float" })

function _AUGMENT_AGENT_TOGGLE()
	augment_agent:toggle()
end
