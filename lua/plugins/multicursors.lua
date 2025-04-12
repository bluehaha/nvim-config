return {
  "smoka7/multicursors.nvim",
  event = "VeryLazy",
  dependencies = {
    "smoka7/hydra.nvim",
  },
  opts = {},
  keys = {
    {
      mode = { "v", "n" },
      "<C-n>",
      "<cmd>MCstart<cr>",
      desc = "Create selection for word under cursor",
    },
  },
}

