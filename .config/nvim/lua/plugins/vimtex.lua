return {
  {
    "lervag/vimtex",
    lazy = false,
    init = function()
      vim.g.vimtex_compiler_method = "latexmk"

      vim.g.vimtex_quickfix_mode = 0

      vim.g.vimtex_syntax_enabled = 1
      vim.g.vimtex_indent_enabled = 1

      vim.g.vimtex_view_method = "zathura"
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "iurimateus/luasnip-latex-snippets.nvim",
    },
    opts = function(_, opts)
      require("luasnip-latex-snippets").setup()
    end,
  },
}
