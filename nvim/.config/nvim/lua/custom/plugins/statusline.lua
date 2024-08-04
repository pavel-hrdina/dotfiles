return {
  'rebelot/heirline.nvim',
  dependencies = { 'zeioth/heirline-components.nvim' },
  opts = function()
    local lib = require 'heirline-components.all'
    return {
      opts = {
        disable_winbar_cb = function(args) -- We do this to avoid showing it on the greeter.
          local is_disabled = not require('heirline-components.buffer').is_valid(args.buf)
            or lib.condition.buffer_matches({
              buftype = { 'terminal', 'prompt', 'nofile', 'help', 'quickfix' },
              filetype = { 'NvimTree', 'dashboard', 'Outline' },
            }, args.buf)
          return is_disabled
        end,
      },
      winbar = { -- UI breadcrumbs bar
        init = function(self)
          self.bufnr = vim.api.nvim_get_current_buf()
        end,
        fallthrough = false,
        lib.component.breadcrumbs(),
        {
          condition = function()
            return not lib.condition.is_active()
          end,
          {
            lib.component.compiler_play(),
            lib.component.fill(),
            lib.component.compiler_build_type(),
            lib.component.compiler_redo(),
          },
        },
        -- Regular winbar
        {
          lib.component.compiler_play(),
          lib.component.fill(),
          lib.component.breadcrumbs(),
          lib.component.fill(),
          lib.component.compiler_redo(),
        },
      },
      statuscolumn = { -- UI left column
        init = function(self)
          self.bufnr = vim.api.nvim_get_current_buf()
        end,
        lib.component.foldcolumn(),
        lib.component.fill(),
        lib.component.numbercolumn(),
        lib.component.signcolumn(),
      } or nil,
      statusline = { -- UI statusbar
        hl = { fg = 'fg', bg = 'bg' },
        lib.component.mode { mode_text = { pad_text = 'center' } },
        lib.component.git_branch { git_branch = { icon = { kind = 'SomeOtherIcon' } } },
        lib.component.file_info { filetype = false, filename = {}, file_modified = false },
        lib.component.git_diff(),
        lib.component.diagnostics { ERROR = {}, WARN = false, INFO = false, HINT = false },
        lib.component.fill(),
        lib.component.cmd_info(),
        lib.component.fill(),
        lib.component.lsp(),
        lib.component.compiler_state(),
        lib.component.virtual_env(),
        lib.component.nav { ruler = false },
        lib.component.mode { surround = { separator = 'right' } },
      },
    }
  end,
  config = function(_, opts)
    local heirline = require 'heirline'
    local heirline_components = require 'heirline-components.all'

    -- Setup
    heirline_components.init.subscribe_to_events()
    heirline.load_colors(heirline_components.hl.get_colors())
    heirline.setup(opts)
  end,
}
