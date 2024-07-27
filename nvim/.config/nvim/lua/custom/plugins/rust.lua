return {
  'mrcjkb/rustaceanvim',
  version = '^4',
  ft = { 'rust' },
  -- LSP configuration
  opts = {
    server = {
      on_attach = function(_, bufnr)
        vim.keymap.set('n', '<leader>cR', function()
          vim.cmd.RustLsp 'codeAction'
        end, { desc = 'Code Action', buffer = bufnr })
        vim.keymap.set('n', '<leader>dr', function()
          vim.cmd.RustLsp 'debuggables'
        end, { desc = 'Rust Debuggables', buffer = bufnr })
      end,
      settings = {
        -- rust-analyzer language server configuration
        ['rust-analyzer'] = {
          cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            runBuildScripts = true,
          },
          -- Add clippy lints for Rust.
          checkOnSave = {
            allFeatures = true,
            command = 'clippy',
            extraArgs = { '--no-deps' },
          },
          diagnostics = {
            enable = true,
            experimental = true,
          },
          procMacro = {
            enable = true,
            ignored = {
              ['async-trait'] = { 'async_trait' },
              ['napi-derive'] = { 'napi' },
              ['async-recursion'] = { 'async_recursion' },
            },
          },
        },
      },
    },
  },
  config = function(_, opts)
    vim.g.rustaceanvim = vim.tbl_deep_extend('keep', vim.g.rustaceanvim or {}, opts or {})
    if vim.fn.executable 'rust-analyzer' == 0 then
      LazyVim.error('**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/', { title = 'rustaceanvim' })
    end
  end,
}
