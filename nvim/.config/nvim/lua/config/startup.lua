-- When nvim is opened with a directory argument, cd into it
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local arg = vim.fn.argv(0)
    if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
      vim.cmd.cd(arg)
    end
    -- In Neovim Lua
  end,
})

local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {} 
  opts.border = opts.border or 'rounded'
  
  return orig_util_open_floating_preview(contents, syntax, opts, ...) 
end

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.md", "*.txt"},
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = 'en_us'
    end,
})
