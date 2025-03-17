return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    explorer = { enabled = true, },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true, sources = { explorer = { layout = { layout = { position = "right" } } } } },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    layout = { enabled = true },
  },
  --keys = {
  -- Top Pickers & Explorer
  --},
}
