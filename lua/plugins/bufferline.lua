-- ~/.config/nvim/lua/plugins/bufferline.lua
return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        separator_style = "thin",
        always_show_bufferline = true,
        show_close_icon = false,
        show_buffer_close_icons = false,
        offsets = {
          -- Reserve space in tabline when Snacks explorer is open
          { filetype = "snacks_explorer", text = "Explorer", highlight = "Directory", separator = true },
        },
      },
    },
    keys = {
      -- Navigate buffers
      { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },

      -- Reorder buffers
      { "]B", "<cmd>BufferLineMoveNext<CR>", desc = "Move buffer right" },
      { "[B", "<cmd>BufferLineMovePrev<CR>", desc = "Move buffer left" },

      -- Buffer actions
      { "<leader>bX", "<cmd>BufferLinePickClose<CR>", desc = "Pick close buffer" },
      { "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", desc = "Close other buffers" },
      { "<leader>bh", "<cmd>BufferLineCloseLeft<CR>", desc = "Close buffers to the left" },
      { "<leader>bl", "<cmd>BufferLineCloseRight<CR>", desc = "Close buffers to the right" },
      { "<leader>bp", "<cmd>BufferLineTogglePin<CR>", desc = "Toggle pin buffer" },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)

      -- Fast buffer jumps: <leader>1..9
      for i = 1, 9 do
        vim.keymap.set(
          "n",
          "<leader>" .. i,
          "<cmd>BufferLineGoToBuffer " .. i .. "<CR>",
          { silent = true, desc = "Go to buffer " .. i }
        )
      end
    end,
  },
}

