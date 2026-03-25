-- ============================================================
--  LSP + Mason — language server support for Python & Java
-- ============================================================
return {
  -- Mason: auto-install LSP servers
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed   = "✓",
            package_pending     = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },

  -- Bridge between Mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",    -- Python LSP
          "jdtls",      -- Java LSP (Eclipse JDT)
        },
        automatic_installation = true,
      })
    end,
  },

  -- LSP engine
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Shared on_attach: set keymaps when LSP attaches
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd",        vim.lsp.buf.definition,      opts)
        vim.keymap.set("n", "gD",        vim.lsp.buf.declaration,     opts)
        vim.keymap.set("n", "gr",        vim.lsp.buf.references,      opts)
        vim.keymap.set("n", "gi",        vim.lsp.buf.implementation,  opts)
        vim.keymap.set("n", "K",         vim.lsp.buf.hover,           opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,         opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,    opts)
        vim.keymap.set("n", "<leader>f",  vim.lsp.buf.format,         opts)
        vim.keymap.set("n", "[d",        vim.diagnostic.goto_prev,    opts)
        vim.keymap.set("n", "]d",        vim.diagnostic.goto_next,    opts)
      end

      -- Diagnostic display style
      vim.diagnostic.config({
        virtual_text  = { prefix = "●" },
        signs         = true,
        underline     = true,
        update_in_insert = false,
        severity_sort = true,
        float         = { border = "rounded", source = "always" },
      })

      -- ── Python ────────────────────────────────────────────
      lspconfig.pyright.setup({
        capabilities = capabilities,
        on_attach    = on_attach,
        settings = {
          python = {
            analysis = {
              typeCheckingMode   = "basic",
              autoSearchPaths    = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- ── Java ─────────────────────────────────────────────
      -- jdtls is configured via nvim-jdtls for per-project workspace
      -- Basic fallback so lspconfig can still start it:
      lspconfig.jdtls.setup({
        capabilities = capabilities,
        on_attach    = on_attach,
      })
    end,
  },

  -- Auto-completion engine
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp    = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
