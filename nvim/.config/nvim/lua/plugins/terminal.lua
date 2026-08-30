return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      size = function ()
        return math.floor(vim.o.columns * 0.45)
      end,
      open_mapping = [[<c-j>]],
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = "vertical",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
      },
    },
  }
}
