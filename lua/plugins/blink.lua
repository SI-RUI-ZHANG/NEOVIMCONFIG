return {
  {
    "saghen/blink.cmp",
    build = "cargo +nightly build --release",
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      fuzzy = { implementation = "rust" },
      keymap = {
        preset = "default",
        ["<Tab>"] = {
          function(cmp)
            if cmp.accept and cmp.accept() then return true end
          end,
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-t>', true, false, true), 'n', false)
          end,
        },
        ["<S-Tab>"] = {
          function(cmp)
            if cmp.select_prev and cmp.select_prev() then return true end
          end,
          function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-d>', true, false, true), 'n', false)
          end,
        },
      },
    },
  },
}
