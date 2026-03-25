-- ============================================================
--  Neovim init.lua — dotfiles-black-minimal
-- ============================================================

-- ── Core options (before lazy, avoids modifiable-off errors) ─
require("config.options")

-- ── Bootstrap lazy.nvim ──────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ── Load plugins (only lua/plugins/ contains plugin specs) ───
require("lazy").setup("plugins", {
  defaults = { lazy = true },
  install  = { colorscheme = { "blackminimal", "habamax" } },
  checker  = { enabled = false },
  change_detection = { notify = false },
})
