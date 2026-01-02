return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason_status, mason = pcall(require, "mason")
      local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
      local lspconfig_status, lspconfig = pcall(require, "lspconfig")

      if not (mason_status and mason_lspconfig_status and lspconfig_status) then
        return
      end

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = { "pyright", "ts_ls", "html", "cssls", "clangd", "jdtls", "lua_ls" },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      end

      local servers = { "pyright", "ts_ls", "html", "cssls", "clangd", "jdtls", "lua_ls" }
      for _, lsp in ipairs(servers) do
        local status, config = pcall(function() return lspconfig[lsp] end)
        if status and config then
          config.setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end
      end
    end,
  },
}
