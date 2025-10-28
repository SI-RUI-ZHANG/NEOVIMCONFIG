local map, opts = vim.keymap.set, { noremap = true, silent = true }

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- ----- Normal mode (shared and editor-agnostic) -----
-- Window navigation with Shift-H J K L (Normal only)
map("n", "H", "<C-w>h", opts)
map("n", "J", "<C-w>j", opts)
map("n", "K", "<C-w>k", opts)
map("n", "L", "<C-w>l", opts)
-- <leader>j/<leader>k are used for buffer navigation (bufferline)
map("n", "-", "<C-w>s", opts)
map("n", "\\", "<C-w>v", opts)
-- <leader>c / <leader>C handled by bufferline (deterministic close)
-- drop Ctrl-window navigation in favor of Shift-HJKL

-- Editing
map("n", "Y", "y$", opts)
map("n", "<leader>a", "A", opts)
map("n", "<leader>i", "I", opts)
map({ "n", "v" }, "<Tab>", ">>", opts)
map({ "n", "v" }, "<S-Tab>", "<<", opts)

-- Word search motions
map({ "n", "v" }, "gs", "%", opts) -- jump to matching pair

-- ----- Visual mode -----
map("v", "<leader>i", "g<c-a>", opts)
map("v", "<leader>I", "g<c-x>", opts)
-- removed visual <leader>j/<leader>k to avoid conflict with buffer nav
map("v", "<Tab>", ">gv", opts)
map("v", "<S-Tab>", "<gv", opts)
-- Some terminals send <Esc>[Z for <S-Tab>; add fallback
map({ "n" }, "<Esc>[Z", "<<", opts)
map({ "v" }, "<Esc>[Z", "<gv", opts)
-- Remove Visual H/L to keep Shift-HJKL Normal-only

-- Begin/End of line on gh/gl (Normal + Visual)
map({ "n", "v" }, "gh", "^", opts)
map({ "n", "v" }, "gl", "$", opts)
