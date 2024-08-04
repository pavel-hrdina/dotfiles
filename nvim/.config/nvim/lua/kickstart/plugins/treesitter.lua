return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      -- Autoinstall languages that are not installed
      ensure_installed = {
        'rust',
        'python',
        'markdown',
        'markdown_inline',
        'bash',
        'yaml',
        'lua',
        'vim',
        'query',
        'vimdoc',
        'latex', -- requires tree-sitter-cli (installed automatically via Mason)
        'html',
        'css',
        'mermaid',
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
    },
    config = function(_, opts)
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
