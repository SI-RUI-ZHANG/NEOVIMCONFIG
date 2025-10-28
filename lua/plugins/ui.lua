return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "auto", icons_enabled = true },
    },
  },

  -- Icons (shared dep)
  { "nvim-tree/nvim-web-devicons", lazy = true },
}
