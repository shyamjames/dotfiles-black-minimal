-- ============================================================
--  nvim-autopairs — auto-close brackets, parens, quotes
-- ============================================================
return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require("nvim-autopairs")
      autopairs.setup({
        check_ts = true,   -- use Treesitter for smarter pairing
        ts_config = {
          lua  = { "string" },   -- don't pair inside strings
          java = { "string" },
          python = { "string" },
        },
        fast_wrap = {
          map            = "<M-e>",   -- Alt+e to fast-wrap word
          chars          = { "{", "[", "(", '"', "'" },
          pattern        = [=[[%'%"%)%>%]%)%}%,]]=],
          end_key        = "$",
          keys           = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma    = true,
          manual_position = true,
          highlight      = "PmenuSel",
          highlight_grey = "LineNr",
        },
      })

      -- Integrate with nvim-cmp: insert `(` after function completion
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp           = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
