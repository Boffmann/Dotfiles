local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,

		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },

		preview = {
			treesitter = true,
			highlight_limit = 2 * 1024 * 1024,
		},

		-- Only overrides of Telescope's defaults
		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
		live_grep = {
			-- treesitter runs at priority 100+ and overwrites Telescope's match highlight.
			-- Regex syntax runs at priority 0, so TelescopePreviewMatch wins.
			preview_config = { treesitter = false },
		},
		grep_string = {
			preview_config = { treesitter = false },
		},
	},
	extensions = {},
})

vim.api.nvim_set_hl(0, "TelescopePreviewMatch", { bg = "#b16286", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "TelescopePreviewLine", { bg = "#665c54" })

-- previewers.vimgrep only applies TelescopePreviewMatch when entry.colend is set,
-- which ripgrep output never provides. Apply it ourselves via matchadd (priority 10,
-- higher than extmarks at 0, window-local so it cleans up automatically).
-- Can probably be removed after fix to this issue: https://github.com/nvim-telescope/telescope.nvim/issues/3441
vim.api.nvim_create_autocmd("FileType", {
	pattern = "TelescopePrompt",
	callback = function(ev)
		local prompt_bufnr = ev.buf
		vim.api.nvim_create_autocmd({ "CursorMoved", "TextChangedI" }, {
			buffer = prompt_bufnr,
			callback = vim.schedule_wrap(function()
				if not vim.api.nvim_buf_is_valid(prompt_bufnr) then
					return
				end
				local ok, action_state = pcall(require, "telescope.actions.state")
				if not ok then
					return
				end
				local picker = action_state.get_current_picker(prompt_bufnr)
				if not picker then
					return
				end
				local previewer = picker.previewer
				-- previewer is always a table; unwrap only when it's a list (no .state at top level)
				if type(previewer) == "table" and not previewer.state then
					previewer = previewer[1]
				end
				if not previewer or not previewer.state then
					return
				end
				local winid = previewer.state.winid
				if not winid or not vim.api.nvim_win_is_valid(winid) then
					return
				end
				-- Strip the prompt prefix from the raw buffer line
				local raw = vim.api.nvim_buf_get_lines(prompt_bufnr, 0, 1, false)[1] or ""
				local prefix = picker.prompt_prefix or ""
				local query = (#prefix > 0 and raw:sub(1, #prefix) == prefix) and raw:sub(#prefix + 1) or raw
				pcall(vim.api.nvim_win_call, winid, function()
					if previewer.state._match_hl_id then
						pcall(vim.fn.matchdelete, previewer.state._match_hl_id)
						previewer.state._match_hl_id = nil
					end
					if query ~= "" then
						-- \V = very nomagic: treat query as a literal string
						previewer.state._match_hl_id =
							vim.fn.matchadd("TelescopePreviewMatch", "\\V" .. vim.fn.escape(query, "\\"))
					end
				end)
			end),
		})
	end,
})
