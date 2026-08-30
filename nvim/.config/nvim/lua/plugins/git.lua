return {
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        signs                        = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged                 = {
          add          = { text = '┃' },
          change       = { text = '┃' },
          delete       = { text = '_' },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        signs_staged_enable          = true,
        signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
        numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                       = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir                 = {
          follow_files = true
        },
        auto_attach                  = true,
        attach_to_untracked          = false,
        current_line_blame           = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts      = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
        blame_formatter              = nil, -- Use default
        sign_priority                = 6,
        update_debounce              = 100,
        status_formatter             = nil,   -- Use default
        max_file_length              = 40000, -- Disable if file is longer than this (in lines)
        preview_config               = {
          -- Options passed to nvim_open_win
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1
        },
        on_attach                    = function(bufnr)
          local gitsigns = require('gitsigns')

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              vim.cmd.normal({ ']c', bang = true })
            else
              gitsigns.nav_hunk('next')
            end
          end, { desc = "Git: Next Change" })

          map('n', '[c', function()
            if vim.wo.diff then
              vim.cmd.normal({ '[c', bang = true })
            else
              gitsigns.nav_hunk('prev')
            end
          end, { desc = "Git: Previous Change" })

          -- Actions
          -- map('n', '<leader>hs', gitsigns.stage_hunk)
          map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Git: Hunk Reset" })

          map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }, { desc = "Git: Hunk Stage" })
          end)

          map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }, { desc = "Git: Hunk Reset" })
          end)

          -- map('n', '<leader>hS', gitsigns.stage_buffer)
          -- map('n', '<leader>hR', gitsigns.reset_buffer)
          map('n', '<leader>hp', gitsigns.preview_hunk, { desc = "Git: Hunk Preview" })
          map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = "Git: Hunk Preview Inline" })
          --
          -- map('n', '<leader>hb', function()
          --   gitsigns.blame_line({ full = true })
          -- end)

          map('n', '<leader>hd', gitsigns.diffthis, { desc = "Git: Diff This (Unstaged)" })

          map('n', '<leader>hD', function()
            gitsigns.diffthis('~')
          end, { desc = "Git: Diff This (Last Commit)" })

          -- map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
          -- map('n', '<leader>hq', gitsigns.setqflist)
          --
          -- Toggles
          map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = "Git: Toggle Line Blame" })
          map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = "Git: Toggle Word diff" })

          -- Text object
          -- map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
        end
      }
    end
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' },
    },
    opts = {
      disable_signs                = false,
      disable_context_highlighting = false,
      disable_commit_conf_headers  = true,
      graph_style                  = 'unicode',
      -- ignored_settings       = { 'NeogitPushPopup--force-with-lease', 'NeogitPushPopup--force', 'NeogitSort' },
      kind                         = 'tab',
      -- commit_editor         = {
      --   kind = 'split',
      -- },
      integrations                 = { diffview = true },
      sections                     = {
        recent    = { hidden = false },
        unstaged  = { hidden = false, folded = false },
        staged    = { hidden = false },
        stashes   = { hidden = false },
        untracked = { hidden = false, folded = false },
      },
    },
  },
}
