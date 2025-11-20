return {
  "pair_programming",
  name = "pair_programming",
  dir = vim.fn.stdpath("config") .. "/lua/plugins/pair_programming",
  config = function()
    -- Add commands
    vim.api.nvim_create_user_command("PairProgramming", function()
      require("plugins.pair_programming.layouts").pair_programming()
    end, {})
    -- Add this to your existing config setup file

    -- Set up pair programming layouts

    -- Add keymaps
    vim.keymap.set("n", "<leader>pp", function()
      require("plugins.pair_programming.layouts").apply_layout("pair_programming")
    end, { noremap = true, silent = true })

    -- Add toggle keymap
    vim.keymap.set("n", "<leader>pt", function()
      require("plugins.pair_programming.layouts").toggle_layout()
    end, { noremap = true, silent = true, desc="Enable layout" })

    vim.keymap.set("n", "<leader>pk", "<cmd>Screenkey<CR>", { noremap = true, silent = true })

    vim.keymap.set('n', '<leader>pf', require('plugins.pair_programming.layouts').toggle_file_switch_tracking,
      { noremap = true, silent = true, desc = "Show file switch info" })

    vim.keymap.set('n', '<leader>pr', require('plugins.pair_programming.layouts').toggle_linenr,
      { noremap = true, silent = true, desc = "Toggel relative line Nr." })

    vim.keymap.set('n', '<leader>pa', "<cmd>PairProgrammingHelper<CR>",
      { noremap = true, silent = true, desc = "Enable Pairing helper stuff" })

    -- Add commands
    vim.api.nvim_create_user_command("PairProgramming", function()
      require("plugins.pair_programming.layouts").apply_layout("pair_programming")
    end, {})

    vim.api.nvim_create_user_command("PairProgrammingHelper", function()
      require("plugins.pair_programming.layouts").toggle_linenr()
      require("plugins.pair_programming.layouts").toggle_file_switch_tracking()
      vim.cmd("Screenkey")
    end, {})

    vim.api.nvim_create_user_command("ThreeColumn", function()
      require("plugins.pair_programming.layouts").apply_layout("three_column")
    end, {})

    -- Add toggle command
    vim.api.nvim_create_user_command("ToggleLayout", function()
      require("plugins.pair_programming.layouts").toggle_layout()
    end, {})
  end

  -- Call the setup function
}
