-- Transparent plugin
return {
  {
    "xiyaowong/nvim-transparent",
    opts = {
      enable = true, -- enable transparency
      extra_groups = { "NormalFloat", "NvimTreeNormal" }, -- optional: add floating windows & tree
    },
  },
}
