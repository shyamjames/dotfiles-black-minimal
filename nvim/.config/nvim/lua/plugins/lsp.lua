-- ============================================================
--  LSP + Mason — language server support for Python & Java
-- ============================================================
return {
  -- Mason: auto-install LSP servers
  {
    "williamboman/mason.nvim",
    cmd   = "Mason",
    build = ":MasonUpdate",
    opts  = {
      ui = {
        border = "rounded",
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },

  -- Bridge between Mason and nvim-lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    event        = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      -- ── Shared on_attach keymaps ────────────────────────────
      local on_attach = function(_, bufnr)
        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = bufnr, silent = true, desc = desc })
        end
        map("gd",          vim.lsp.buf.definition,     "Go to definition")
        map("gD",          vim.lsp.buf.declaration,    "Go to declaration")
        map("gr",          vim.lsp.buf.references,     "List references")
        map("gi",          vim.lsp.buf.implementation, "Go to implementation")
        map("K",           vim.lsp.buf.hover,          "Hover docs")
        map("<leader>rn",  vim.lsp.buf.rename,         "Rename symbol")
        map("<leader>ca",  vim.lsp.buf.code_action,    "Code action")
        map("<leader>f",   function() vim.lsp.buf.format({ async = true }) end, "Format")
        map("[d",          vim.diagnostic.goto_prev,   "Prev diagnostic")
        map("]d",          vim.diagnostic.goto_next,   "Next diagnostic")
      end

      -- ── Capabilities (extend with cmp if loaded) ─────────────
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok then capabilities = cmp_lsp.default_capabilities(capabilities) end

      -- ── Diagnostic display ────────────────────────────────────
      vim.diagnostic.config({
        virtual_text     = { prefix = "●" },
        signs            = true,
        underline        = true,
        update_in_insert = false,
        severity_sort    = true,
        float            = { border = "rounded", source = "always" },
      })

      -- ── Mason-lspconfig install list ──────────────────────────
      require("mason-lspconfig").setup({
        ensure_installed       = { "pyright", "jdtls" },
        automatic_installation = true,
      })

      -- ── Explicit Server Setup ─────────────────────────────────
      -- Python
      require("lspconfig").pyright.setup({
        on_attach    = on_attach,
        capabilities = capabilities,
        settings = {
          python = {
            analysis = {
              typeCheckingMode       = "basic",
              autoSearchPaths        = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      })

      -- Java
      local util = require("lspconfig.util")
      local root_markers = { ".git", "pom.xml", "build.gradle", "gradlew", "mvnw" }
      local root_dir = util.root_pattern(unpack(root_markers))(vim.fn.expand("%:p:h")) or vim.fn.getcwd()
      local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
      local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

      require("lspconfig").jdtls.setup({
        on_attach    = on_attach,
        capabilities = capabilities,
        cmd = {
          "jdtls",
          "-data", workspace_dir,
          "--jvm-arg=-XX:+IgnoreUnrecognizedVMOptions",
          "--jvm-arg=-javaagent:" .. vim.fn.expand("$HOME") .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
        },
        root_dir = root_dir,
        settings = {
          java = {
            configuration = {
              runtimes = {
                { name = "JavaSE-17", default = true }, -- Adjust if needed
              },
            },
          },
        },
      })
    end,
  },

  -- LSP engine
  { "neovim/nvim-lspconfig", lazy = true },

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
      local cmp     = require("cmp")
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
