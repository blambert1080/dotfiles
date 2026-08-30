return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
      require("kanagawa").setup({
        transparent = true,
      })
      -- vim.cmd([[colorscheme kanagawa-wave]])
    end,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").setup({
        after_palette = function(palette)
          palette.border_fg = "#434c5e"
          palette.fg_float_border = "#434c5e"
          palette.fg_popup_border = "#434c5e"
          palette.comment = "#60728a"
        end,
        on_highlight = function(highlights, palette)
          highlights.Visual = {
            bg = palette.gray1,
            bold = true,
          }
          highlights.CursorLine = { bg = "NONE" }
        end,
        transparent = {
          -- Enable transparent background.
          bg = true,
          -- Enable transparent background for floating windows.
          float = true,
        },
        bright_border = false,
        telescope = {
          style = "classic",
        },
      })
      require("nordic").load()

      vim.api.nvim_set_hl(0, "TabLine", {
        bg = "NONE",
      })

      vim.api.nvim_set_hl(0, "TabLineFill", {
        bg = "NONE",
        nocombine = true,
      })

      vim.api.nvim_set_hl(0, "TabLineSel", {
        bg = "NONE",
      })
    end,
  },
  {
    "wtfox/luna.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
}
