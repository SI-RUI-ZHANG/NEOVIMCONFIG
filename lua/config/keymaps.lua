local function map(mode, lhs, rhs, desc, opts)
  local options = vim.tbl_extend("force", { noremap = true, silent = true, desc = desc }, opts or {})
  vim.keymap.set(mode, lhs, rhs, options)
end

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- ----- Normal mode (shared and editor-agnostic) -----
-- Window navigation with Shift-H J K L (Normal only)
map("n", "H", "<C-w>h", "Focus window left")
map("n", "J", "<C-w>j", "Focus window down")
map("n", "K", "<C-w>k", "Focus window up")
map("n", "L", "<C-w>l", "Focus window right")
-- <leader>j/<leader>k are used for buffer navigation (bufferline)
map("n", "-", "<C-w>s", "Split window below")
map("n", "\\", "<C-w>v", "Split window right")

-- Editing
map("n", "Y", "y$", "Yank to end of line")
map("n", "<leader>a", "A", "Append at end of line")
map("n", "<leader>i", "I", "Insert at line start")
map({ "n", "v" }, "<Tab>", ">>", "Indent right")
map({ "n", "v" }, "<S-Tab>", "<<", "Indent left")

-- Word search motions
map({ "n", "v" }, "gs", "%", "Jump to matching pair")

-- ----- Visual mode -----
map("v", "<leader>i", "g<c-a>", "Increment selection numbers")
map("v", "<leader>I", "g<c-x>", "Decrement selection numbers")
-- removed visual <leader>j/<leader>k to avoid conflict with buffer nav
map("v", "<Tab>", ">gv", "Indent selection right")
map("v", "<S-Tab>", "<gv", "Indent selection left")
-- Some terminals send <Esc>[Z for <S-Tab>; add fallback
map("n", "<Esc>[Z", "<<", "Indent left (fallback)")
map("v", "<Esc>[Z", "<gv", "Indent selection left (fallback)")
-- Remove Visual H/L to keep Shift-HJKL Normal-only

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
