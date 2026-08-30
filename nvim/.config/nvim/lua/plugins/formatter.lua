return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      javascriptreact = { "prettierd" },
      typescriptreact = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      json = { "prettierd" },
      go = { "gofmt" },
    },
    format_on_save = function(bufnr)
      if vim.bo[bufnr].filetype == "lua" then
        return
      end
      if vim.bo[bufnr].filetype == "json" then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end
  },
}
