-- lua/plugins/copilot.lua
return {
	{
		"github/copilot.vim",
		event = "InsertEnter",
		init = function()
			-- Don't let Copilot grab <Tab> (avoids conflicts with nvim-cmp/blink)
			vim.g.copilot_no_tab_map = true
			vim.keymap.set(
				"i",
				"<C-l>",
				'copilot#Accept("<CR>")',
				{ expr = true, replace_keycodes = false, desc = "Copilot Accept" }
			)
			vim.keymap.set("i", "<M-]>", "<Plug>(copilot-next)", { desc = "Copilot Next" })
			vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Copilot Prev" })
			vim.keymap.set("i", "<C-]>", "<Plug>(copilot-dismiss)", { desc = "Copilot Dismiss" })
		end,
	},
}
