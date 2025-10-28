-- Leaders must be defined before any mappings are created
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Plugin manager bootstrap + setup (lazy.nvim)
require("config.lazy")

-- Core editor settings and global keymaps
require("config.options")
require("config.keymaps")
require("config.autoread")
