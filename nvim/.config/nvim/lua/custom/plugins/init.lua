-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")

		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.beautysh,
				null_ls.builtins.diagnostics.shellcheck,
				null_ls.builtins.formatting.yamlfix,
				null_ls.builtins.diagnostics.yamllint,
				null_ls.builtins.completion.spell,
				null_ls.builtins.diagnostics.ansiblelint,
				null_ls.builtins.formatting.markdownlint,
			},
		})
	end,
}
