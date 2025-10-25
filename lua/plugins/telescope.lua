-- ~/.config/nvim/lua/plugins/telescope.lua
return {
  {
    "nvim-telescope/telescope.nvim",
    version = false, -- latest
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep"   },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers"     },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>",  desc = "Help"        },
    },
    opts = {},
  },
}

