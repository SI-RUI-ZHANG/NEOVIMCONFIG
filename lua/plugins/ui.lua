-- ~/.config/nvim/lua/plugins/ui.lua
return {
  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "auto", icons_enabled = true },
    },
    -- cond = not vim.g.vscode, -- optional: skip in Cursor
  },

  -- Indentation guides (v3 uses "ibl" module)
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {}, -- defaults are fine to start
  },

  -- Icons (shared dep)
  { "nvim-tree/nvim-web-devicons", lazy = true },
}

