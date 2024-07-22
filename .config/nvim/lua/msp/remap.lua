local inoremap = require("msp.keymap").inoremap
local vnoremap = require("msp.keymap").vnoremap
local nnoremap = require("msp.keymap").nnoremap
local wk = require("which-key")

local ls = require "luasnip"
-- Bring up netr (Explorer)
-- Move current line up/down.
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

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


nnoremap("<leader><leader>s", "<CMD>:source /home/maxi/.config/nvim/after/plugin/luasnip.lua<CR>")


-- Make it so you can switch tab's with movement keys.
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






-- Mapping to input timezones. Needs $TZ="<TIMEZONE>" in .bashrc to work
--inoremap ("x", "<cmd>:let old_tz=$TZ<CR><cmd>:let $TZ='UTC'<CR><C-R>=strftime('%Y-%m-%d T%H:%M:%S %Z')<CR><cmd>:let $TZ=old_tz<CR>")

-- Mappings.

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
--local opts = { noremap=true, silent=true }
--nnoremap( '<leader>e', vim.diagnostic.open_float, opts)
--nnoremap( '[d', vim.diagnostic.goto_prev, opts)
--nnoremap( ']d', vim.diagnostic.goto_next, opts)
--nnoremap( '<leader>q', vim.diagnostic.setloclist, opts)


----- FILE ----
wk.add({
        { "<leader>f", group="file" },
        {"<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Search File" }, -- create a binding with label
        {"<leader>ft", "<cmd>Telescope live_grep<cr>", desc = "Search Text" },  -- create a binding with label
        {"<leader>fw", "<cmd>:w<CR>", desc = "Save File" },
        {"<keader>fr", "<cmd>:file ", desc = "Rename File" },
    })

-- FileTree --
wk.add({
    { "<leader>e",  "<cmd>:Lexplore<CR>", desc = "View File-Tree" }
})

------ VIEW ---
wk.add({
    {
        {"<leader>v", group="view"},
        {"<leader>vd", "<cmd>vsplit term://vd <cfile><CR>", desc = "View Data" }
    }
})

-- Make highlights go away
wk.add({
    {"<leader>n", "<cmd>:set hlsearch!<CR>", desc = "Toggle Highlights" }
})


-- GOlang specific settings
wk.add({
    {
        {"<leader>l", group = "LSP"},
        {"<leader>lK", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover Documentation" },
        {"<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename Variable" },
        {"<leader>lf",  "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format File" },
        {"<leader>lg", group = "GO"},
        {"<leader>lgf", "<cmd>:lua require('go.format').goimport()<CR>", desc = "Fix Imports" },
        {"<leader>lgc", "<cmd>:GoCmt<CR>", desc = "Comment" },
        {"<leader>lgt", group="Tags"},
        {"<leader>lgcta", "<cmd>:GoAddTag<CR>", desc = "Add Tags" },
        {"<leader>lgctr", "<cmd>:GoRMTag<CR>", desc = "Remove Tags" },
    },
    })

-- Debbuging --
wk.add({

    {
        {"<leader>d", group="Debug"},
        {"<leader>db", "<Cmd>:lua require('dap').toggle_breakpoint()<CR>", desc = "Breakpoint" },
        {"<leader>dB", "<Cmd>:lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", desc = "Breakpoint Condition"},
        {"<leader>dp", "<Cmd>:lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", desc = "Log Point" },
        {"<leader>dr", "<Cmd>:lua require('dap').repl.open()<CR>", desc = "Repl Open" },
        {"<leader>dl", "<Cmd>:lua require('dap').run_last()<CR>", desc = "Run Last" },
    }
})

-- GIT --
-- Undotree --
wk.add({
    {"<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" }
})
-- Harpoon --
wk.add({
    {
        {"<leader>h", group="Harpoon"},
        {"<leader>ha", "<cmd>:lua require('harpoon.mark').add_file()<CR>", desc = "Add current file" },
        {"<leader>ht", "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<CR>", desc = "Toggle menu" },
        {"<leader>hn",  "<cmd>:lua require('harpoon.ui').nav_next()<CR>", desc = "Next item" },
        {"<leader>hp",  "<cmd>:lua require('harpoon.ui').nav_prev()<CR>", desc = "Previous item" },
        {"<leader>h1",  "<cmd>:lua require('harpoon.ui').nav_file(1)<CR>", desc = "Select File 1" },
        {"<leader>h2",  "<cmd>:lua require('harpoon.ui').nav_file(2)<CR>", desc = "Select File 1" },
        {"<leader>h3",  "<cmd>:lua require('harpoon.ui').nav_file(3)<CR>", desc = "Select File 1" },
        {"<leader>h4",  "<cmd>:lua require('harpoon.ui').nav_file(4)<CR>", desc = "Select File 1" },
    }
})
-- Make Harpoon File 1 and 2 accessible from the main menue as well (1 less keypress)
wk.add({
    {"<leader>1", "<cmd>:lua require('harpoon.ui').nav_file(1)<CR>", desc = "Select File 1" },
    {"<leader>2", "<cmd>:lua require('harpoon.ui').nav_file(2)<CR>", desc = "Select File 2" }
})

wk.add({"<leader>z", "<cmd>:ZenMode<CR>", desc = "Zen-Mode" })

wk.add({
    {
        {"<leader>t", group="Trouble"},
        {"<leader>tt", "<cmd>:lua require('trouble').toggle()<CR>", desc = "Toggle trouble" },
        {"<leader>tw", "<cmd>:lua require('trouble').toggle('workspace_diagnostics')<CR>", desc = "Toggle Workspace Diagnostics" },
        {"<leader>td", "<cmd>:lua require('trouble').toggle('document_diagnostics')<CR>", desc = "Toggle Document Diagnostics" },
        {"<leader>tq", "<cmd>:lua require('trouble').toggle('quickfix')<CR>", desc = "Toggle quickfix list" },
        {"<leader>tr", "<cmd>:lua require('trouble').toggle('lsp_references')<CR>", desc = "Toggle lsp references" },
    },
})
