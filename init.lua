-- ~/.config/nvim/init.lua

-- 1) Leaders must be defined before any mappings are created
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- 2) Plugin manager bootstrap + setup (lazy.nvim)
require("config.lazy")

-- 3) Core editor settings and your global keymaps
require("config.options")
require("config.keymaps")
require("config.autoread")
