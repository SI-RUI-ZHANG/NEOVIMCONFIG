return {
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

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {}, -- enables gc/gcc mappings
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
}
