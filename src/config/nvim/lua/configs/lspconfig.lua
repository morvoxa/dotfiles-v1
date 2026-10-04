require("nvchad.configs.lspconfig").defaults()

local servers = { "vtsls", "tailwindcss", "svelte", "emmet_ls", "css", "clangd", "pyright", "ruff", "zls" }
vim.lsp.config("tailwindcss", {
  filetypes = { "svelte", "javascript", "typescript", "javascriptreact", "typescriptreact" },
})
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
