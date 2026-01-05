return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      mason.setup()

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Use LspAttach autocommand for keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { noremap = true, silent = true, buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        end,
      })

      mason_lspconfig.setup({
        ensure_installed = { "pyright", "ts_ls", "html", "cssls", "clangd", "jdtls", "lua_ls" },
        handlers = {
          function(server_name)
            -- Use pcall to avoid the "framework" warning crash if indexing fails in 0.11
            local status, config = pcall(function() return lspconfig[server_name] end)
            if status and config then
              config.setup({
                capabilities = capabilities,
              })
            end
          end,
        },
      })
    end,
  },
}
