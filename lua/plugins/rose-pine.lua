return {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
                require("rose-pine").setup({
                        disable_background = true,
                        disable_float_background = true,
                        highlight_groups = {
                                Normal = { bg = "none" },
                                NormalNC = { bg = "none" },
                                NormalFloat = { bg = "none" },
                                FloatBorder = { bg = "none" },
                                SignColumn = { bg = "none" },
                        },
                })

                vim.cmd("colorscheme rose-pine")
        end,
}
