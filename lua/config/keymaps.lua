
local map, opts = vim.keymap.set, { noremap = true, silent = true }

-- Clear search highlight
map('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)

-- ----- Normal mode (shared and editor-agnostic) -----
-- Navigation/layout
-- map('n', 'J', 'gT', opts)       -- prev tab
-- map('n', 'K', 'gt', opts)       -- next tab
map('n', 'H', '^',  opts)
map('n', 'L', '$',  opts)
map('n', 's', '%',  opts)
-- map('n', '[', 'g;', opts)       -- older change
-- map('n', ']', 'g,', opts)       -- newer change
map('n', 'M', "'",  opts)       -- make ' easy to reach for marks/jumps
map('n', '<leader>j', '<C-d>zz', opts)
map('n', '<leader>k', '<C-u>zz', opts)
map('n', '<leader>w', '<C-w>w', opts)
map('n', '<leader>hs', '<C-w>s', opts)
map('n', '<leader>vs', '<C-w>v', opts)

-- Editing
map('n', 'Y', 'y$', opts)
map('n', '<leader>a', 'A', opts)
map('n', '<leader>i', 'I', opts)
map('n', '<Tab>',   '>>',  opts)
map('n', '<S-Tab>', '<<',  opts)

-- Word search motions
map('n', '(', '#', opts)  -- search word backward
map('n', ')', '*', opts)  -- search word forward
