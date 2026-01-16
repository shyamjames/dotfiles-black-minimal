return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")
    autopairs.setup({
      check_ts = true, -- Enable treesitter support
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
      },
      disable_filetype = { "TelescopePrompt", "vim" },
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment'
      },
    })

    -- Custom CR (Enter) mapping for smart indentation
    local cmp = require("cmp")
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    
    -- Smart Enter key behavior
    local Rule = require('nvim-autopairs.rule')
    local npairs = require('nvim-autopairs')
    
    -- Integration with nvim-cmp for confirm_done
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    
    -- Enhanced CR mapping with proper indentation
    local remap = vim.api.nvim_set_keymap
    local npairs_map = npairs.completion_confirm
    
    -- Override CR behavior
    vim.keymap.set("i", "<CR>", function()
      if cmp.visible() then
        return cmp.confirm({ select = false })
      else
        return npairs.autopairs_cr()
      end
    end, { expr = true, noremap = true })
  end,
}
