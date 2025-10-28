return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
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
      auto_install = false,
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
