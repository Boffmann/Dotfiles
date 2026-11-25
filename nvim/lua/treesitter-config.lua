require("nvim-treesitter").install({
	"cpp",
	"python",
	"lua",
	"luadoc",
	"java",
	"javascript",
	"elixir",
	-- "markdown",
	"vim",
	"vimdoc",
	"bash",
	"go",
	"glsl",
	"rust",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		if not pcall(vim.treesitter.start, ev.buf) then
			return
		end
		vim.bo[ev.buf].syntax = "ON" -- keep regex highlighting (was additional_vim_regex_highlighting)
		if vim.bo[ev.buf].filetype ~= "yaml" then
			vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

vim.filetype.add({
	extension = {
		metal = "cpp",
	},
})
