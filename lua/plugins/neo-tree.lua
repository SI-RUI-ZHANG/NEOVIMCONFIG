-- ~/.config/nvim/lua/plugins/neo-tree.lua
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer (Neo-tree)" },
      { "<leader>E", "<cmd>Neotree focus<cr>",  desc = "Explorer: focus"     },
    },
    opts = {},
    -- If you often use Cursor (vscode-neovim) and prefer VSCode’s explorer, gate it:
    -- cond = not vim.g.vscode,
  },
}

