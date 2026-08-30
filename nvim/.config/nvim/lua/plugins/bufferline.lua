return {
  {
    "akinsho/bufferline.nvim",
    dependencies = { 'famiu/bufdelete.nvim' },
    opts = {
      options = {
        close_command = "Bdelete! %d",
        right_mouse_command = "Bdelete! %d",
        custom_filter = function(buf_number)
          -- Get the name of the buffer
          local name = vim.api.nvim_buf_get_name(buf_number)

          -- Hide if the name is empty (i.e., a [No Name] buffer)
          if name == "" then
            return false
          end

          return true
        end,
        offsets = {
          {
            filetype = "snacks_layout_box",
            text = function()
              return vim.fn.getcwd()
            end,
            text_align = "center",
            highlight = "Directory",
            separator = true
          }
        },
        separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
        diagnostics = "nvim_lsp",

        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end
      },

    }
  }
}
