return {
  "stevearc/oil.nvim",
  keys = {
    -- Add keybinding for opening Oil
    { "e", "<cmd>Oil<cr>", desc = "Open Oil file explorer" },
  },
  opts = {
    -- Default configuration options
    view_options = {
      show_hidden = true,
    },
    -- Float window settings
    float = {
      padding = 2,
      max_width = 0,
      max_height = 0,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
    -- Add preview
    preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      win_options = {
        winblend = 0,
      },
    },
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
}
