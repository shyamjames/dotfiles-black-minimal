-- ============================================================
--  Treesitter — syntax highlighting + indentation
--  Using `opts` so lazy.nvim calls setup() after install
-- ============================================================
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    -- pcall guard: skip setup gracefully if not yet installed (first launch)
    config = function()
      local ok, ts = pcall(require, "nvim-treesitter.configs")
      if not ok then return end
      ts.setup({
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
