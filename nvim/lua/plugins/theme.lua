return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
        on_colors = function(colors)
          colors.bg = "#1a1a1a"
          colors.bg_dark = "#161616"
          colors.bg_float = "#1a1a1a"
          colors.bg_highlight = "#262626"
          colors.bg_popup = "#1a1a1a"
          colors.bg_sidebar = "#1a1a1a"
          colors.bg_statusline = "#1a1a1a"
          colors.bg_visual = "#333333"
          colors.fg = "#e6e6e6"
          colors.fg_dark = "#888888"
          colors.fg_float = "#e6e6e6"
          colors.fg_gutter = "#555555"
          colors.border = "#e6e6e6"
        end,
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
