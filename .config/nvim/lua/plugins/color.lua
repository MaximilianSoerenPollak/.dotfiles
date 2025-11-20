-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   config = function()
--     require("rose-pine").setup({
--       variant = "main",    -- auto, main, moon, or dawn
--       dark_variant = "main", -- main, moon, or dawn
--       dim_inactive_windows = true,
--       extend_background_behind_borders = false,
--
--       enable = {
--         terminal = false,
--         legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
--         migrations = true,        -- Handle deprecated options automatically
--       },
--
--       styles = {
--         bold = true,
--         italic = false,
--         transparency = false,
--       },
--     })
--   end,
-- }

return {
  "vague2k/vague.nvim",
  dependencies = { "rose-pine/neovim" },
  config = function()
    require("vague").setup({
      style = {
        comments = "none",
        strings = "none",
        keyword_return = "none",
      },
      plugins = {
        cmp = {
          match = "none",
          match_fuzzy = "none",
        }
      }
    })
  end
}
