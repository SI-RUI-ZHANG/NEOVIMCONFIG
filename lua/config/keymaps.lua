
local map, opts = vim.keymap.set, { noremap = true, silent = true }

-- Clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)

-- ----- Normal mode (shared and editor-agnostic) -----
-- Navigation/layout
map('n', 'H', '^',  opts)
map('n', 'L', '$',  opts)
map('n', '<leader>j', '<C-d>zz', opts)
map('n', '<leader>k', '<C-u>zz', opts)
map('n', '<leader>hs', '<C-w>s', opts)
map('n', '<leader>vs', '<C-w>v', opts)
map("n", "<leader>c", "<C-w>c", opts)
map("n", "<leader>C", "<C-w>o", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)


-- Editing
map('n', 'Y', 'y$', opts)
map('n', '<leader>a', 'A', opts)
map('n', '<leader>i', 'I', opts)
map({'n', 'v'}, '<Tab>',   '>>',  opts)
map({'n', 'v'}, '<S-Tab>', '<<',  opts)

-- Word search motions
map('n', '(', '#', opts)  -- search word backward
map('n', ')', '*', opts)  -- search word forward

-- ----- Visual mode -----
map('v', '<leader>i', 'g<c-a>', opts)
map('v', '<leader>k', '<c-u>',  opts)
map('v', '<Leader>j', '<C-d>',  opts)
map('v', 's', '%',               opts)
map('v', '<Tab>',   '>gv',       opts)
map('v', '<S-Tab>', '<gv',       opts)
map('v', 'H', '^',               opts)
map('v', 'L', '$',               opts)


