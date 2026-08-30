return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
    },
    config = function()
      local ensure_installed = {
        "lua",
        "markdown",
        "markdown_inline",
        "bash",
        "python",
        "tsx",
        "html",
        "hcl",
        "go",
      }
      require 'nvim-treesitter'.setup({})

      require'nvim-treesitter'.install(ensure_installed)

      -- Enable Neovim 0.12 native highlighting automatically per FileType
      vim.api.nvim_create_autocmd("FileType", {
        pattern = ensure_installed,
        callback = function(args)
          -- Avoid activating on special buffers like telescope, dashboards, or quickfix
          if vim.bo[args.buf].buftype == "" then
            vim.treesitter.start(args.buf)
          end
        end,
      })

    end
  }
}
