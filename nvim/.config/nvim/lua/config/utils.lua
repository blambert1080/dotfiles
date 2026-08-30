local M = {}

-- Close Buffers When Explorer is Open
function M.close_buffer()
  local wins = vim.api.nvim_tabpage_list_wins(0)
  local non_tree_wins = 0
  for _, win in ipairs(wins) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative == "" then
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype ~= "snacks_layout_box" then
        non_tree_wins = non_tree_wins + 1
      end
    end
  end
  local buf = vim.api.nvim_get_current_buf()
  if non_tree_wins > 1 then
    vim.cmd("close")
  end
  vim.cmd("Bdelete! " .. buf)
end

-- Set Scratch Filetype
local column_widths = { 0, 0, 0, 0 }

local function update_column_widths(item)
  column_widths[1] = math.max(column_widths[1], vim.api.nvim_strwidth(item.cwd))
  column_widths[2] = math.max(column_widths[2], vim.api.nvim_strwidth(item.icon))
  column_widths[3] = math.max(column_widths[3], vim.api.nvim_strwidth(item.name))
  column_widths[4] = math.max(column_widths[4], vim.api.nvim_strwidth(item.branch))
end

local function process_item(item)
  item._path = item.file
  item.branch = item.branch and ("branch:%s"):format(item.branch) or ""
  item.cwd = item.cwd and vim.fn.fnamemodify(item.cwd, ":p:~") or ""
  item.icon = item.icon or Snacks.util.icon(item.ft, "filetype")
  item.preview = { text = item.file }
  update_column_widths(item)
end

local function process_items(items)
  for _, item in ipairs(items) do
    process_item(item)
  end
end

local function format_item_text(item)
  local parts = { item.cwd, item.icon, item.name, item.branch }
  for i, part in ipairs(parts) do
    parts[i] = part .. string.rep(" ", column_widths[i] - vim.api.nvim_strwidth(part))
  end
  return table.concat(parts, " ")
end

function M.select_scratch()
  local items = Snacks.scratch.list()
  process_items(items)

  Snacks.picker.pick({
    items = items,
    format = "text",
    layout = {
      layout = { title = " Select Scratch Buffer: " },
      preview = true,
      preset = function()
        return vim.o.columns >= 120 and "default" or "vertical"
      end,
    },
    on_change = function()
      vim.cmd.startinsert()
    end,
    transform = function(item)
      item.text = format_item_text(item)
    end,
    win = {
      input = {
        keys = {
          ["<c-x>"] = { "delete", mode = { "i", "n" } },
        },
      },
    },
    actions = {
      delete = function(picker, item)
        for _, entry in ipairs(items) do
          if entry.cwd == item.cwd then
            os.remove(item.file)
          end
        end
        picker:close()
        M.select_scratch()
      end,
    },
    confirm = function(picker, item)
      if item then
        picker:close()
        Snacks.scratch.open({ icon = item.icon, file = item.file, name = item.name, ft = item.ft })
      end
    end,
  })
end

function M.new_scratch(filetypes)
  Snacks.picker.pick({
    items = filetypes,
    format = "text",
    layout = {
      preset = "vscode",
      preview = false,
      layout = { title = " Select a filetype: " },
    },
    confirm = function(picker, item)
      picker:close()
      vim.schedule(function()
        local items = picker:items()
        if #items == 0 then
          Snacks.scratch({ ft = picker:filter().pattern })
        else
          Snacks.scratch({ ft = item.text })
        end
      end)
    end,
  })
end

-- Close GitSigns Diff View
vim.keymap.set("n", "q", function()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    local bufname = vim.api.nvim_buf_get_name(buf)

    if bufname:find("^gitsigns://") then
      vim.api.nvim_win_close(win, true)
    end
  end
end, { buffer = bufnr, desc = "Close gitsigns diff" })


-- Update Buffer when Opencode makes changes
-- Create a rule to reload the file when you focus Neovim or move your cursor
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  command = "if mode() != 'c' | checktime | endif",
})

-- Show a message at the bottom when the file changes and reloads
vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  command = "echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None",
})

return M
