-- ============================================================
--  Neovim init.lua — dotfiles-black-minimal
--  Color palette: #1a1a1a bg · #e6e6e6 fg
--  Plugin manager: lazy.nvim (auto-bootstrapped)
-- ============================================================

-- Load core options first (no plugin dependencies)
require("plugins.options")

-- ── Bootstrap lazy.nvim ─────────────────────────────────────
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

-- ── Load plugins ────────────────────────────────────────────
require("lazy").setup("plugins", {
  defaults = { lazy = false },
  install  = { colorscheme = { "blackminimal" } },
  checker  = { enabled = false },
  change_detection = { notify = false },
})
