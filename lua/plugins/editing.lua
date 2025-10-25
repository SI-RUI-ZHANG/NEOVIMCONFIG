-- ~/.config/nvim/lua/plugins/editing.lua
return {
  -- Which-key (key-hint popup)
  { "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer local keymaps (which-key)",
      },
    },
  },

  -- Comments
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {}, -- enables gc/gcc mappings
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true, -- = require("nvim-autopairs").setup({})
  },

  -- Surroundings (ys, cs, ds, etc.)
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
}

