-- ~/.config/nvim/lua/config/pair_programming.lua
local M = {}

-- Keep track of the current active layout
M.active_layout = nil

-- Terminal settings configuration
M.terminal_config = {
  line_numbers = false,
  background_color = "Black",
  font_size = 12,
  start_insert = true,
  -- Add more terminal settings as needed
}

-- Explorer settings configuration
M.explorer_config = {
  width = 30,
  background_color = "#2E3440",
  -- Add more explorer settings as needed
}

-- File switching tracking state
M.file_switch_tracking = {
  enabled = false,
  prev_file = nil,
  current_file = nil,
  augroup_id = nil
}

-- Function to notify about file switches
function M.file_switch_notify()
  -- Get current file path
  local current_file = vim.fn.expand('%:p')
  local current_filename = vim.fn.expand('%:t')
  
  -- Only track actual files (not empty buffers or special buffers)
  if current_file == "" or current_filename == "" then
    return
  end
  
  -- Skip if it's the same file
  if current_file == M.file_switch_tracking.current_file then
    return
  end
  
  -- Update history
  M.file_switch_tracking.prev_file = M.file_switch_tracking.current_file
  M.file_switch_tracking.current_file = current_file
  
  -- Skip notification if this is the first file (no previous file)
  if M.file_switch_tracking.prev_file == nil then
    return
  end
  
  -- Get readable filenames for notification
  local prev_filename = vim.fn.fnamemodify(M.file_switch_tracking.prev_file, ':t')
  
  -- Show notification
  vim.notify(
    string.format("Switched from '%s' --> '%s'", prev_filename, current_filename),
    vim.log.levels.INFO,
    {
      title = "File Switch",
      timeout = 3000 -- 3 seconds
    }
  )
end

-- Toggle file switch tracking on/off
function M.toggle_file_switch_tracking()
  if M.file_switch_tracking.enabled then
    -- Turn off tracking
    if M.file_switch_tracking.augroup_id then
      vim.api.nvim_del_augroup_by_id(M.file_switch_tracking.augroup_id)
      M.file_switch_tracking.augroup_id = nil
    end
    M.file_switch_tracking.enabled = false
    vim.notify("File switch tracking disabled", vim.log.levels.INFO)
  else
    -- Turn on tracking
    local augroup = vim.api.nvim_create_augroup("FileSwitchTracking", { clear = true })
    M.file_switch_tracking.augroup_id = augroup
    
    vim.api.nvim_create_autocmd({ "BufEnter" }, {
      group = augroup,
      callback = function()
        M.file_switch_notify()
      end,
      desc = "Track file switching with notifications",
    })
    
    M.file_switch_tracking.enabled = true
    M.file_switch_tracking.prev_file = nil  -- Reset tracking
    M.file_switch_tracking.current_file = vim.fn.expand('%:p')
    
    vim.notify("File switch tracking enabled", vim.log.levels.INFO)
  end
end

-- Apply terminal settings to the current window
function M.apply_terminal_settings()
  -- Disable line numbers if configured
  if not M.terminal_config.line_numbers then
    vim.wo.number = false
    vim.wo.relativenumber = false
  end

  -- Set background color
  vim.cmd("hi Terminal guibg=" .. M.terminal_config.background_color)

  -- Apply any other terminal settings
  -- vim.opt.termguicolors = true -- Enable if needed
end

-- Define the pair programming layout
function M.pair_programming()
  -- Close all windows except the current one
  vim.cmd("only")

  -- Create the explorer on the right
  vim.cmd("vsplit")
  vim.cmd("wincmd l") -- Move to right window

  -- Open explorer in this right window
  local has_nvimtree = pcall(require, "nvim-tree")
  if has_nvimtree then
    vim.cmd("NvimTreeOpen")
    vim.cmd("vertical resize " .. M.explorer_config.width) -- Set explorer width

    -- Apply explorer customizations if using nvim-tree
    if M.explorer_config.background_color then
      vim.cmd("hi NvimTreeNormal guibg=" .. M.explorer_config.background_color)
    end
  else
    vim.cmd("Explore")
    vim.cmd("vertical resize " .. M.explorer_config.width) -- Set explorer width
  end

  -- Move back to the code window
  vim.cmd("wincmd h")

  -- Create the terminal splits at the bottom
  vim.cmd("split")
  vim.cmd("wincmd j") -- Move to bottom window

  -- Create two terminal windows side by side
  vim.cmd("vsplit")

  -- Configure left terminal
  vim.cmd("wincmd h")         -- Move to left terminal
  vim.cmd("terminal")
  M.apply_terminal_settings() -- Apply terminal settings
  vim.cmd("startinsert")

  -- Configure right terminal
  vim.cmd("wincmd l")         -- Move to right terminal
  vim.cmd("terminal")
  M.apply_terminal_settings() -- Apply terminal settings
  vim.cmd("startinsert")

  -- Set the height of the terminal area
  vim.cmd("resize 10")

  -- Return to the code window
  vim.cmd("wincmd k")
  vim.cmd("wincmd h")

  -- Set this as the active layout
  M.active_layout = "pair_programming"

  vim.notify("Activated pair programming layout", vim.log.levels.INFO)
end

-- Update terminal settings
function M.update_terminal_settings(settings)
  for key, value in pairs(settings) do
    M.terminal_config[key] = value
  end

  -- If a layout is active, reapply it to update settings
  if M.active_layout and M[M.active_layout] then
    M[M.active_layout]()
  end

  vim.notify("Terminal settings updated", vim.log.levels.INFO)
end

-- Update explorer settings
function M.update_explorer_settings(settings)
  for key, value in pairs(settings) do
    M.explorer_config[key] = value
  end

  -- If a layout is active, reapply it to update settings
  if M.active_layout and M[M.active_layout] then
    M[M.active_layout]()
  end

  vim.notify("Explorer settings updated", vim.log.levels.INFO)
end

-- Define any other layouts you might want
function M.three_column()
  vim.cmd("only")
  vim.cmd("vsplit")
  vim.cmd("vsplit")
  vim.cmd("wincmd h")

  -- Set this as the active layout
  M.active_layout = "three_column"

  vim.notify("Activated three column layout", vim.log.levels.INFO)
end

-- Define the default layout (just a single editor window)
function M.default_layout()
  vim.cmd("only")

  -- Clear the active layout
  M.active_layout = nil

  vim.notify("Returned to default layout", vim.log.levels.INFO)
end

-- Toggle the current layout on/off
function M.toggle_layout()
  if M.active_layout then
    -- If a layout is active, switch to default
    M.default_layout()
  else
    -- If no layout is active, switch to the last used layout or pair_programming as fallback
    local last_layout = M.last_active_layout or "pair_programming"
    if M[last_layout] then
      M[last_layout]()
    else
      M.pair_programming()
    end
  end
end

-- Apply a specific layout and remember what was active before
function M.apply_layout(layout_name)
  if M.active_layout then
    -- Remember the last active layout for toggling back
    M.last_active_layout = M.active_layout
  end

  -- Apply the requested layout
  if layout_name and M[layout_name] then
    M[layout_name]()
  else
    vim.notify("Layout '" .. (layout_name or "nil") .. "' not found", vim.log.levels.ERROR)
  end
end

return M
