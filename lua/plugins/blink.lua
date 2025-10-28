-- lua/plugins/blink.lua
return {
  {
    "saghen/blink.cmp",
    build = "cargo +nightly build --release", -- ensures nightly toolchain is used
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      fuzzy = { implementation = "rust" },    -- error if Rust lib isn't available
      -- Insert-mode Tab/S-Tab: accept or indent/unindent
      keymap = {
        preset = "default",
        ["<Tab>"] = {
          function(cmp)
            -- accept selected item if menu is visible; return true to stop chain
            if cmp.accept and cmp.accept() then return true end
          end,
          function()
            -- indent the current line in insert-mode
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-t>', true, false, true), 'n', false)
          end,
        },
        ["<S-Tab>"] = {
          function(cmp)
            -- select previous item if menu is visible; return true to stop chain
            if cmp.select_prev and cmp.select_prev() then return true end
          end,
          function()
            -- unindent the current line in insert-mode
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-d>', true, false, true), 'n', false)
          end,
        },
      },
    },
  },
}
