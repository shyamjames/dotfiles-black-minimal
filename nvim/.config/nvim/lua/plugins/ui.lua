-- ============================================================
--  UI plugins — statusline, git signs, indent guides
--  (lightweight, all matching the black-minimal palette)
-- ============================================================
return {
  -- Minimal statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      local c = require("config.colorscheme").colors
      require("lualine").setup({
        options = {
          theme = {
            normal   = { a = { fg = c.bg, bg = c.fg_subtle, gui = "bold" },
                         b = { fg = c.fg, bg = c.bg_sel },
                         c = { fg = c.fg_dim, bg = c.bg } },
            insert   = { a = { fg = c.bg, bg = c.blue,    gui = "bold" } },
            visual   = { a = { fg = c.bg, bg = c.magenta, gui = "bold" } },
            replace  = { a = { fg = c.bg, bg = c.red,     gui = "bold" } },
            command  = { a = { fg = c.bg, bg = c.yellow,  gui = "bold" } },
            inactive = { a = { fg = c.fg_dim, bg = c.bg_alt },
                         b = { fg = c.fg_dim, bg = c.bg_alt },
                         c = { fg = c.fg_dim, bg = c.bg_alt } },
          },
          component_separators = "",
          section_separators   = "",
          globalstatus         = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Git diff signs in the gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "▎" },
          change       = { text = "▎" },
          delete       = { text = "" },
          topdelete    = { text = "" },
          changedelete = { text = "▎" },
        },
        current_line_blame = false,
      })
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "│", highlight = "LineNr" },
        scope  = { enabled = true, highlight = "Comment" },
      })
    end,
  },

  -- Activate colorscheme (must come early)
  {
    "folke/lazy.nvim",   -- placeholder to ensure priority loading
    priority = 1000,
    config = function()
      vim.cmd("colorscheme blackminimal")
    end,
  },
}
