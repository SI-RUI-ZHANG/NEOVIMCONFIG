-- ~/.config/nvim/lua/plugins/bufferline.lua
return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				separator_style = "thin",
				always_show_bufferline = true,
				show_close_icon = false,
				show_buffer_close_icons = false,
				offsets = {
					-- Reserve space in tabline when Snacks explorer is open
					{ filetype = "snacks_explorer", text = "Explorer", highlight = "Directory", separator = true },
				},
			},
		},
		keys = {
			-- Navigate buffers
			-- { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
			-- { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
			{ "<leader>j", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
			{ "<leader>k", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },

			-- Reorder buffers
			{ "<leader>J", "<cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
			{ "<leader>K", "<cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },

			-- Buffer actions
			-- Pick close will be accessible via <leader>c (smart close) when single-window
			-- Remove close-left/right as requested; keep pin
			{ "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle pin buffer" },
		},
		config = function(_, opts)
			require("bufferline").setup(opts)

			-- Fast buffer jumps: <leader>1..9
			for i = 1, 9 do
				vim.keymap.set(
					"n",
					"<leader>" .. i,
					"<cmd>BufferLineGoToBuffer " .. i .. "<CR>",
					{ silent = true, desc = "Go to buffer " .. i }
				)
			end

				-- Smart Close on <leader>c and Close Others on <leader>C
				local function smart_close()
					-- Detect if any Snacks Explorer window is open
					local function has_explorer()
						for _, w in ipairs(vim.api.nvim_list_wins()) do
							local b = vim.api.nvim_win_get_buf(w)
							if vim.bo[b] and vim.bo[b].filetype == "snacks_explorer" then
								return true
							end
						end
						return false
					end

					local cur_is_explorer = (vim.bo.filetype == "snacks_explorer")
					local explorer_open = has_explorer()

					-- When explorer is open and we're on a file buffer, replace this window
					-- with the next available file buffer and then delete the previous buffer.
					if explorer_open and not cur_is_explorer then
						local old = vim.api.nvim_get_current_buf()
						vim.cmd("silent! update")
						-- try next, then previous, then create a new empty buffer
						local function switch_buffer()
							local before = vim.api.nvim_get_current_buf()
							local ok = pcall(vim.cmd, "silent! bnext")
							if ok and vim.api.nvim_get_current_buf() ~= before then return true end
							ok = pcall(vim.cmd, "silent! bprevious")
							if ok and vim.api.nvim_get_current_buf() ~= before then return true end
							pcall(vim.cmd, "enew")
							return true
						end
						switch_buffer()
						-- delete the old buffer explicitly to keep this window intact
						pcall(vim.api.nvim_buf_delete, old, { force = false })
						return
					end

					-- Default behavior: if multiple windows, close the current one
					local win_count = vim.fn.winnr("$")
					if win_count > 1 then
						vim.cmd("close")
						return
					end

					-- Single window: save-if-modified then delete current buffer
					if vim.bo.modified then
						vim.cmd("write")
					end
					local ok, Snacks = pcall(require, "snacks")
					if ok and Snacks.bufdelete then
						Snacks.bufdelete()
					else
						vim.cmd("bdelete")
					end
				end

			local function close_others()
				if vim.fn.winnr("$") > 1 then
					vim.cmd("only")
				end
				vim.cmd("BufferLineCloseOthers")
			end

			vim.keymap.set("n", "<leader>c", smart_close, { silent = true, desc = "Close window or current buffer" })
			vim.keymap.set(
				"n",
				"<leader>C",
				close_others,
				{ silent = true, desc = "Close other buffers (keep window)" }
			)

			-- Global pick-close on <leader>x
			vim.keymap.set(
				"n",
				"<leader>x",
				"<cmd>BufferLinePickClose<CR>",
				{ silent = true, desc = "Pick close buffer" }
			)
		end,
	},
}
