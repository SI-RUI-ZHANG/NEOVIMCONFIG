local function map(mode, lhs, rhs, desc, opts)
	local options = vim.tbl_extend("force", { noremap = true, silent = true, desc = desc }, opts or {})
	vim.keymap.set(mode, lhs, rhs, options)
end

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- ----- Normal mode (shared and editor-agnostic) -----
map("n", "H", "^", "Jump to start of line")
map("n", "L", "$", "Jump to end of line")

-- Window navigation with Ctrl-h/j/k/l (Normal only)
map("n", "<C-h>", "<C-w>h", "Focus window left")
map("n", "<C-j>", "<C-w>j", "Focus window down")
map("n", "<C-k>", "<C-w>k", "Focus window up")
map("n", "<C-l>", "<C-w>l", "Focus window right")

-- Split windows
-- J/K are used for buffer navigation (bufferline)
map("n", "-", "<C-w>s", "Split window below")
map("n", "\\", "<C-w>v", "Split window right")

-- Window layout
-- Make window wider/narrower
map("n", "_", "<cmd>vertical resize -2<cr>", "make window narrower")
map("n", "+", "<cmd>vertical resize +2<cr>", "make window wider")
-- Make window taller/shorter
map("n", "<S-Up>", "<cmd>resize +2<CR>", "Make window taller")
map("n", "<S-Down>", "<cmd>resize -2<CR>", "Make window shorter")

-- Editing
map("n", "Y", "y$", "Yank to end of line")
map("n", "<leader>a", "A", "Append at end of line")
map("n", "<leader>i", "I", "Insert at line start")
map({ "n", "v" }, "<Tab>", ">>", "Indent right")
map({ "n", "v" }, "<S-Tab>", "<<", "Indent left")
-- Fast in-file jump (15 lines) on <leader>j/k
map("n", "<leader>j", "15j", "Move down 15 lines")
map("n", "<leader>k", "15k", "Move up 15 lines")

-- Word search motions
map({ "n", "v" }, "s", "%", "Jump to matching pair")

-- ----- Visual mode -----
map("v", "<leader>i", "g<c-a>", "Increment selection numbers")
map("v", "<leader>I", "g<c-x>", "Decrement selection numbers")
-- removed visual <leader>j/<leader>k to avoid conflict with buffer nav
map("v", "<Tab>", ">gv", "Indent selection right")
map("v", "<S-Tab>", "<gv", "Indent selection left")

-- Begin/End of line on gh/gl (Normal + Visual)
map({ "n", "v" }, "gh", "^", "Jump to start of line")
map({ "n", "v" }, "gl", "$", "Jump to end of line")

-- Save all & quit
map("n", "<leader>Q", "<cmd>xa<cr>", "Save all buffers and quit")

-- Marks: delete one / delete all
map("n", "<leader>md", function()
	vim.ui.input({ prompt = "Delete mark (a-zA-Z0-9): " }, function(input)
		if input and input ~= "" then
			vim.cmd("delmarks " .. input)
		end
	end)
end, "Delete a mark")

map("n", "<leader>mD", function()
	vim.cmd("delmarks! | delmarks A-Z 0-9")
end, "Delete all marks")

-- Smart close on <leader>c (overrides plugin mapping after VeryLazy)
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		map("n", "<leader>c", function()
			require("config.smart_close").close()
		end, "Smart close window/buffer")
	end,
})
