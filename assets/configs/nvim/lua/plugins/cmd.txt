return {
  "jonarrien/telescope-cmdline.nvim",
  keys = {
    { ":", ":Telescope cmdline<CR>", { noremap = true, desc = "Cmdline" } },
    { "<leader><leader>", "<cmd>Telescope cmdline<cr>", desc = "Cmdline" },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension "cmdline"
  end,
}
