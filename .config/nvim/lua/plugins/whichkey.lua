return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    -- Define keymap functions (from your keymap.lua)
    local function bind(op, outer_opts)
      outer_opts = outer_opts or { noremap = true }
      return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
          outer_opts,
          opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
      end
    end

    local nmap = bind("n", { noremap = false })
    local nnoremap = bind("n")
    local vnoremap = bind("v")
    local xnoremap = bind("x")
    local inoremap = bind("i")

    -- Initialize which-key
    local wk = require("which-key")
    wk.setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    })

    -- vim.api.nvim_create_user_command("Z", "w | qa", {})
    -- vim.keymap.set("n", "<S-z>", "<cmd>Z<cr>", {silent = true})
    -- LuaSnip integration
    local ls = require("luasnip")

    vnoremap("<C-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    vnoremap("<C-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    vnoremap("<C-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    inoremap("<C-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, { silent = true })

    inoremap("<C-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    inoremap("<C-l>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end)

    -- Normal keymaps from your remap.lua
    vnoremap("J", ":m '>+1<CR>gv=gv")
    vnoremap("K", ":m '<-2<CR>gv=gv")

    nnoremap("<C-Left>", ":<cmd>tabprevious<CR>")
    nnoremap("<C-Right>", "<cmd>:tabnext<CR>")

    -- Mappings for Debugging
    nnoremap("<F5>", "<Cmd>:lua require('dap').continue()<CR>")
    nnoremap("<F1>", "<Cmd>:lua require('dap').step_over()<CR>")
    nnoremap("<F2>", "<Cmd>:lua require('dap').step_into()<CR>")
    nnoremap("<F3>", "<Cmd>:lua require('dap').step_out()<CR>")
    nnoremap("<F6>", "<Cmd>:DapVirtualTextToggle<CR>")
    nnoremap("<F9>", "<Cmd>:lua require('dapui').toggle()<CR>")
    nnoremap("<F10>", "<Cmd>:lua require('dap').terminate()<CR>")


    vim.keymap.set("t", "<esc>", "<c-\\><c-n>", { desc = "Disable Terminal Mode" })


    -- Which-key mappings from your remap.lua
    wk.add({
      { "<leader><leader>",   group = "Misc" },
      { "<leader><leader>k",  "<cmd>ShowkeysToggle<CR>", desc = "Toggle ShowKeys" },
      { "<leader><leader>c",  group = "Comment Box" },
      { "<leader><leader>cb", "<cmd>CBccbox<CR>",        desc = "Centered box & centered text", mode = "v" },
      { "<leader><leader>cl", "<cmd>CBcline<CR>",        desc = "Simple line",                  mode = "v" },
      { "<leader><leader>ci", "<cmd>CBllbox19<CR>",      desc = "Popping comment",              mode = "v" },
      { "<leader><leader>cy", "<cmd>CBy<CR>",            desc = "Yank text of box comment",     mode = "v" },
      { "<leader><leader>cd", "<cmd>CBd<CR>",            desc = "Delete comment box",           mode = "v" },
    })
    local Snacks = require('snacks')
    wk.add({
      { "<leader>f",  group = "file" },
      { "<leader>ff", function() Snacks.picker.files() end,    desc = "Find Files" },
      { "<leader>ft", function() Snacks.picker.grep() end,     desc = "Find Text" },
      { "<leader>e",  function() Snacks.explorer() end,        desc = "File Explorer" },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end,  desc = "Buffers" },
      { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },

    })
    wk.add({
      { "<leader>s",  group = "Diagnostics" },
      { "<leader>td", function() Snacks.picker.diagnostics() end,        desc = "Workspace Diagnostics" },
      { "<leader>tD", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>tq", function() Snacks.picker.qflist() end,             desc = "Quickfix List" },
      { "<leader>tu", function() Snacks.picker.undo() end,               desc = "Undo History" },
    })

    --LSP
    -- wk.add({
    --   { "gd", function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
    --   { "gD", function() Snacks.picker.lsp_declarations() end,     desc = "Goto Declaration" },
    --   { "gr", function() Snacks.picker.lsp_references() end,       nowait = true,                  desc = "References" },
    --   { "gI", function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
    --   { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    -- })
    -- wk.add({
    --   { "gd", "gd", desc = "Goto Definition" },
    --   { "gD", "gD", desc = "Goto Declaration" },
    --   { "gr", "gr", nowait = true, desc = "References" },
    --   { "gI", "gI", desc = "Goto Implementation" },
    --   { "gy", "gy", desc = "Goto T[y]pe Definition" },
    -- })


    wk.add({
      {
        { "<leader>v",  group = "view" },
        { "<leader>vd", "<cmd>vsplit term://vd <cfile><CR>", desc = "View Data" },
      }
    })

    wk.add({
      { "<leader>n", "<cmd>:set hlsearch!<CR>", desc = "Toggle Highlights" }
    })

    wk.add({
      {
        { "<leader>l",     group = "LSP" },
        { "<leader>lK",    "<cmd>lua vim.lsp.buf.hover()<CR>",                   desc = "Hover Documentation" },
        { "<leader>lr",    "<cmd>lua vim.lsp.buf.rename()<CR>",                  desc = "Rename Variable" },
        { "<leader>lf",    "<cmd>lua vim.lsp.buf.format()<CR>",                  desc = "Format File" },
        { "<leader>lc",    "<cmd>lua require('conform').format()<CR>",           desc = "Format File via conform" },
        { "<leader>lg",    group = "GO" },
        { "<leader>lgf",   "<cmd>:lua require('go.format').goimport()<CR>",      desc = "Fix Imports" },
        { "<leader>lgc",   "<cmd>:GoCmt<CR>",                                    desc = "Comment" },
        { "<leader>lgt",   group = "Tags" },
        { "<leader>lgcta", "<cmd>:GoAddTag<CR>",                                 desc = "Add Tags" },
        { "<leader>lgctr", "<cmd>:GoRMTag<CR>",                                  desc = "Remove Tags" },
        { "<leader>ss",    function() Snacks.picker.lsp_symbols() end,           desc = "LSP Symbols" },
        { "<leader>sS",    function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      },
    })
    wk.add({
      {
        { "<C-;>",   group = "ToggleTerm" },
        { "<C-;>t",  "<cmd>:ToggleTerm<CR>" },
        { "<C-;>ts", "<cmd>:TermSelect<CR>" },
        { "<C-;>tr", "<cmd>:ToggleTermSetName<CR>" },
        { "<C-;>tb", function()
          vim.ui.input({ prompt = "Name of Terminal: " }, function(name)
            if name then
              vim.cmd("ToggleTerm name=" .. name)
            end
          end)
        end, { noremap = true, silent = true, mode = { "n", "t" } },
          { "<C-;>th", function()
            local name = "HIGHLIGHTING"
            vim.cmd("ToggleTerm name=" .. name)
            local terminal = require("toggleterm.terminal").get(name)
            if terminal then
              terminal:open()
              terminal:send("highlight<CR>")
            end
          end, { noremap = true, silent = true, mode = { "n", "t" } },
          }
        } } })
    wk.add({
      {
        { "<leader>d",  group = "Debug" },
        { "<leader>db", "<Cmd>:lua require('dap').toggle_breakpoint()<CR>",                                           desc = "Breakpoint" },
        { "<leader>dB", "<Cmd>:lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",        desc = "Breakpoint Condition" },
        { "<leader>dp", "<Cmd>:lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", desc = "Log Point" },
        { "<leader>dr", "<Cmd>:lua require('dap').repl.open()<CR>",                                                   desc = "Repl Open" },
        { "<leader>dl", "<Cmd>:lua require('dap').run_last()<CR>",                                                    desc = "Run Last" },
      }
    })

    wk.add({
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" }
    })
    local hp = require('harpoon')
    hp:setup()
    wk.add({
      {
        { "<leader>h",  group = "Harpoon" },
        { "<leader>ha", function() hp:list():add() end,                    desc = "Add current file" },
        { "<leader>ht", function() hp.ui:toggle_quick_menu(hp:list()) end, desc = "Toggle menu" },
        { "<leader>h1", function() hp:list():select(1) end,                desc = "Select File 1" },
        { "<leader>h2", function() hp:list():select(2) end,                desc = "Select File 2" },
        { "<leader>h3", function() hp:list():select(3) end,                desc = "Select File 3" },
        { "<leader>h4", function() hp:list():select(4) end,                desc = "Select File 4" },
      }
    })

    wk.add({
      { "<leader>1", function() hp:list():select(1) end, desc = "Select File 1" },
      { "<leader>2", function() hp:list():select(2) end, desc = "Select File 2" },
    })

    wk.add({ "<leader>z", "<cmd>:ZenMode<CR>", desc = "Zen-Mode" })

    -- Add the which-key leader ? key that was in your original setup
    --
    wk.add({
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)" },
    })
  end,
}
