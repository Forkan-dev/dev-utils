return {
  -- Go: enhanced LSP + code actions + test runner
  { "ray-x/go.nvim",
    ft = "go",
    dependencies = { "ray-x/guihua.lua" },
    config = true },

  -- Laravel Blade template syntax highlighting
  { "jwalton512/vim-blade" },

  -- Dockerfile syntax
  { "ekalinin/Dockerfile.vim" },

  -- GitHub Copilot (optional — requires :Copilot auth)
  { "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = { suggestion = { auto_trigger = true } } },
}
