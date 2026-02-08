return {
  {
    "sainnhe/everforest",
    lazy = false, -- load on startup
    priority = 1000, -- load *before* other plugins
    config = function()
      -- optional: settings before loading the colorscheme
      vim.g.everforest_enable_italic = true -- enable italics (optional)

      -- enable the colorscheme
      vim.cmd.colorscheme("everforest")
      vim.o.background = "dark"

      vim.g.everforest_background = "medium"

      vim.cmd.colorscheme("everforest")
      vim.g.everforest_enable_italic = true
    end,
  },
}
