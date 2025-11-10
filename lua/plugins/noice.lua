return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    {
      'rcarriga/nvim-notify',
      opts = {
        top_down = false,
      },
    },
  },
  config = function()
    require('noice').setup({
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    })

    require('which-key').add({
      {
        '<leader>m',
        desc = '[M]essages',
        icon = '󰍪',
      },
      {
        '<leader>mm',
        function()
          require('noice').cmd('history')
        end,
        desc = 'Show [M]essages [H]istory',
        icon = '󰚢',
      },
      {
        '<leader>md',
        function()
          require('noice').cmd('dismiss')
        end,
        desc = '[M]essages [D]imiss',
        icon = '󱙎',
      },
    })

    vim.api.nvim_create_autocmd({ 'RecordingEnter' }, {
      pattern = '*',
      callback = function()
        require('noice').notify('Recording Macro...', 'macro_start', {
          icon = '🎬',
          render = 'compact',
        })
      end,
    })

    vim.api.nvim_create_autocmd({ 'RecordingLeave' }, {
      pattern = '*',
      callback = function()
        require('noice').notify('Macro Recorded!', 'macro_stop', {
          icon = '✅',
          render = 'compact',
        })
      end,
    })
  end,
}
