return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          icons = {
            glyphs = {
              folder = {
                arrow_closed = "󰅂",
                arrow_open = "󰅀",
              },
            },
          },
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },
}
