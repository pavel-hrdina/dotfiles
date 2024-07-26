return {
  'mrcjkb/rustaceanvim',
  version = '^4',
  ft = { 'rust' },
  init = function()
    vim.g.rustaceanvim = {
      -- Plugin configuration
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },

      -- LSP configuration
      server = {
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
          },
        },
      },
    }
  end,
}
