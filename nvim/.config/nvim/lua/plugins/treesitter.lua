-- ============================================================
--  Treesitter — syntax highlighting + indentation
-- ============================================================
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "python", "java",
          "lua", "vim", "vimdoc",
          "bash", "json", "yaml", "toml",
          "markdown", "markdown_inline",
          "html", "css", "javascript",
          "regex", "comment",
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  },
}
