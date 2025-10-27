-- ~/.config/nvim/lua/config/autoread.lua
vim.opt.autoread = true

local grp = vim.api.nvim_create_augroup("AutoReadExternal", { clear = true })

vim.api.nvim_create_autocmd(
	{ "FocusGained", "BufEnter", "CursorHold", "TermClose", "TermLeave" },
	{ group = grp, command = "checktime" }
)

vim.api.nvim_create_autocmd("FileChangedShellPost", {
	group = grp,
	callback = function(args)
		vim.notify("Reloaded: " .. vim.fn.fnamemodify(args.file, ":."), vim.log.levels.INFO, { title = "autoread" })
	end,
})

-- manual refresh
vim.keymap.set("n", "<leader>rr", "<cmd>checktime<cr>", { desc = "Reload externally changed files" })
