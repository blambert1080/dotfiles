-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }
local utils = require("config.utils")

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- remap navigation
keymap("", "œ", "h", opts)
keymap("", "√", "j", opts)
keymap("", "å", "k", opts)
keymap("", "Å", "k", opts)
keymap("", "ø", "l", opts)
keymap("", "Ø", "l", opts)

-- Normal --
-- Better window navigation
keymap("n", "<S-Left>", "<C-w>h", opts)
keymap("n", "<S-Down>", "<C-w>j", opts)
keymap("n", "<S-Up>", "<C-w>k", opts)
keymap("n", "<S-Right>", "<C-w>l", opts)

-- Better Save
keymap("n", "<C-y>", ":w!<CR>", opts)

-- Add line in normal mode
keymap("n", "<leader>o", "o<ESC>", opts)
keymap("n", "<leader>O", "O<ESC>", opts)

-- Resize with arrows
keymap("n", "<A-Up>", ":resize -2<CR>", opts)
keymap("n", "<A-Down>", ":resize +2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<C-t>", ":bnext<CR>", opts)
keymap("n", "<C-s>", ":bprevious<CR>", opts)

-- Close nvim
keymap("n", "<leader>qa", ":qa<CR>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", utils.close_buffer, opts)
keymap("n", "<C-w>q", ":Bdelete!<CR>", { desc = "Close File" })

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Insert --
-- Press dw fast to exit
keymap("i", "dw", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Visual Block --
-- Move Text Up and Down
keymap("x", "L", ":move '<-2<CR>gv-gv", opts)
keymap("x", "R", ":move '>+1<CR>gv-gv", opts)

-- Plugins --
keymap("n", "<leader>p", ":Lazy<CR>")

keymap("n", "<leader>Ft", ":lua require'telescope'.extensions.live_grep_args.live_grep_args()<CR>", opts)
keymap("n", "<leader>ft", ":Telescope current_buffer_fuzzy_find<CR>", opts)

-- -- Git
-- Keymaps stored in git.lua and snacks.lua

-- -- DAP
-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)

-- Terminal
keymap('t', 'dw', [[<C-\><C-n>]], opts)

-- LSP
keymap("n", "<leader>lf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, opts)
keymap("n", "<leader>m", ":Mason<CR>", opts)
keymap("n", "K", function()
  vim.lsp.buf.hover({ border = "rounded" })
end, { desc = "Show Documentation" })

-- Tab Navigation
keymap("n", "<leader>nt", ":tabnext<CR>", { desc = "Next Tab" })
keymap("n", "<leader>pt", ":tabprevious<CR>", { desc = "Previous Tab" })
keymap("n", "<leader>qt", ":tabclose<CR>", { desc = "Close Tab" })

-- Word Wrap
keymap("n", "<leader>ww", ":set wrap!<CR>", { desc = "Toggle Word Wrap" })
