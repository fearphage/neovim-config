local lspconfig = require('lspconfig')

vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4

-- lspconfig.docker_groovy_lsp.setup({
--   settings = {
--     groovy = {},
--   },
-- name = 'docker-groovy-language-server',
-- cmd = { 'docker', 'run', '--rm', '--interactive', 'phred.local/groovy-language-server' },
-- filetypes = { 'groovy', 'Jenkinsfile' },
-- root_dir = require('lspconfig.util').root_pattern('Jenkinsfile', '.git'),
-- })

-- vim.lsp.start({
--   name = 'npm-groovy-lint',
--   cmd = { 'npm-groovy-lint' },
--   root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'Jenkinsfile' }, { upward = true })[1]),
-- })
-- lspconfig.npm_groovy_lint.setup({
--   settings = {
--     groovy = {},
--   },
-- })
