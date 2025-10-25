-- ~/.config/nvim/lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,              -- load at startup (recommended)
    build = ":TSUpdate",       -- keep parsers in sync with plugin
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc",
        "python",
        "markdown", "markdown_inline",
        "latex", "bibtex",
        "json", "bash", "yaml", "toml",
      },
      highlight = { enable = true },
      indent    = { enable = true },
      -- safer on fresh macs without tree-sitter CLI:
      auto_install = false,    -- set true only if you know you have the CLI
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}

