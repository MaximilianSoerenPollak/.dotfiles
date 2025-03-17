return {
  'akinsho/toggleterm.nvim',
  event = 'ColorScheme',
  config = function()
    local custom_highlights = {
      Normal = { guifg = "#000000", guibg = "#56949f" },
      NormalFloat = { guifg = "#ffffff", guibg = "#587A8D" },
      FloatTitle = { guifg = "#6c7549", guibg = "#6c7549" },
      StatusLineTerm = { guifg = "#ffffff", guibg = "#000000" },
      TermCursor = { guifg = "#ffffff", guibg = "#000000" },
    }
    local width = math.floor(vim.o.columns * 0.55)
    local height = math.floor(vim.o.lines * 0.55)
    require('toggleterm').setup({
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true,
      highlights = custom_highlights,
      name = "TERMINAL",
      hidden = true,
      shade_terminals = false,
      direction = "float",
      size = width,
      float_opts = {
        border = "none",
        relative = "editor",
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        width = width,
        height = height,
        winblend = 0,
        title_pos = "center"
      },
    })
  end
}
