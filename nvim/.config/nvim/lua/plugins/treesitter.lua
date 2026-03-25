-- ============================================================
--  Treesitter — syntax highlighting + indentation
--  Using `opts` so lazy.nvim calls setup() after install
-- ============================================================
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    -- lazy.nvim calls require("nvim-treesitter.configs").setup(opts) for us
    main = "nvim-treesitter.configs",
    opts = {
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
    },
  },
}
