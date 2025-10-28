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
					{ filetype = "snacks_explorer", text = "Explorer", highlight = "Directory", separator = true },
				},
			},
		},
		keys = {
			-- Navigate buffers
			{ "<leader>k", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
			{ "<leader>j", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },

			-- Reorder buffers
			{ "<leader>K", "<cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
			{ "<leader>J", "<cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },

			-- Buffer actions
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

			-- Vanilla mappings: close current buffer (save if modified), close other buffers
			-- vim.keymap.set("n", "<leader>c", function()
			-- 	vim.cmd("silent! update")
			-- 	vim.cmd("bdelete")
			-- end, { silent = true, desc = "Close current buffer (save if modified)" })
			vim.keymap.set(
				"n",
				"<leader>C",
				"<cmd>BufferLineCloseOthers<CR>",
				{ silent = true, desc = "Close other buffers" }
			)

			-- Pick-close on <leader>x
			vim.keymap.set(
				"n",
				"<leader>x",
				"<cmd>BufferLinePickClose<CR>",
				{ silent = true, desc = "Pick close buffer" }
			)
		end,
	},
}
