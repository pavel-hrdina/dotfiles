return {
  'saecki/crates.nvim',
  event = { 'BufRead Cargo.toml' },
  opts = {
    completion = {
      cmp = {
        enabled = true,
      },
    },
  },
  init = function()
    local map = vim.keymap.set

    map({ 'n' }, 'K', function()
      if vim.fn.expand '%:t' == 'Cargo.toml' and require('crates').popup_available() then
        require('crates').show_popup()
      else
        vim.lsp.buf.hover()
      end
    end, { desc = 'Show Create Documentation' })
  end,
}
