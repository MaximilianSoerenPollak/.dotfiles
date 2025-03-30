-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
-- local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local p = require("rose-pine.palette")
local colors = {
  normal = {
    a = { bg = p.rose, fg = p.base, gui = "bold" },
    b = { bg = p.overlay, fg = p.rose },
    c = { bg = p.base, fg = p.text },
    z = { bg = p.pine, fg = p.text, gui = "bold" }
  },
  insert = {},
  visual = {},
  replace = {},
  command = {},

  inactive = {
    a = { bg = p.base, fg = p.subtle, gui = "bold" },
    b = { bg = p.base, fg = p.subtle },
    c = { bg = p.base, fg = p.subtle, gui = "italic" },
  },
}
local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    theme = colors,
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_y = {},
    lualine_z = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

local function get_venv(variable)
  local venv = os.getenv(variable)
  if venv ~= nil and string.find(venv, "/") then
    local orig_venv = venv
    for w in orig_venv:gmatch("([^/]+)") do
      venv = w
    end
    venv = string.format("%s", venv)
  end
  return venv
end

-- Inserts a component in lualine_c at left section
local function insert_component(component, section)
  local s = config.sections[section]
  table.insert(s, component)
end


insert_component({
  'filename',
  path = 3,
  shorting_target = 40,
  cond = conditions.buffer_not_empty,
  -- color = { fg = colors.magenta, gui = 'bold' },
}, "lualine_a"
)



insert_component({
  -- Python VIRTUAL_ENV name.
  function()
    local venv = get_venv("VIRTUAL_ENV") or "NO ENV"
    return " " .. venv
  end,
  cond = function() return vim.bo.filetype == "python" end,
}, "lualine_x")

insert_component({
    'datetime',
    -- options: default, us, uk, iso, or your own format string ("%H:%M", etc..)
    style = '%Y-%M-%d %H:%M',
    color = colors.foam
  },
  "lualine_z"
)

insert_component({
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  -- diff_color = {
  --   added = { fg = colors.green },
  --   modified = { fg = colors.orange },
  --   removed = { fg = colors.red },
  -- },
  cond = conditions.hide_in_width,
}, "lualine_b")


insert_component({
    'branch',
    icon = '',
    -- color = { fg = colors.violet, gui = 'bold' }
  },
  "lualine_b"
)

-- Add components to right sections

insert_component({
    'diagnostics',
    sources = { 'nvim_diagnostic', 'nvim_lsp', 'nvim_workspace_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' }
  },
  -- diagnostics_color = {
  --   error = { fg = colors.red },
  --   warn = { fg = colors.yellow },
  --   info = { fg = colors.cyan },
  -- },},
  "lualine_y"
)


-- Now don't forget to initialize lualine
-- lualine.setup(config)
return {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = function()
    require('lualine').setup(config)
  end,
}
