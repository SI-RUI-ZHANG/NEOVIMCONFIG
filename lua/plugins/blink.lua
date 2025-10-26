-- lua/plugins/blink.lua
return {
  {
    "saghen/blink.cmp",
    build = "cargo +nightly build --release", -- ensures nightly toolchain is used
    dependencies = { "rafamadriz/friendly-snippets" },
    opts = {
      fuzzy = { implementation = "rust" },    -- error if Rust lib isn't available
    },
  },
}

