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
    end, {silent = true})
vnoremap("<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, {silent = true})

vnoremap("<C-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end)

inoremap("<C-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
    end, {silent = true})

inoremap("<C-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end,{silent = true})

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
wk.register({
    f = {
        name = "file", -- optional group name
        s = { "<cmd>Telescope find_files<cr>", "Search File" }, -- create a binding with label
        t = { "<cmd>Telescope live_grep<cr>", "Search Text" }, -- create a binding with label
        w = { "<cmd>:w<CR>", "Save File" },
        r = { "<cmd>:file ", "Rename File" },
    },
}, { prefix = "<leader>" })

-- FileTree --
wk.register({
    ["<leader>e"] = { "<cmd>:Lexplore<CR>", "View File-Tree" }
})

------ VIEW ---
wk.register({
    v = {
        name = "view",
        d = { "<cmd>vsplit term://vd <cfile><CR>", "View Data" }
    },
}, { prefix = "<leader>" })

-- Make highlights go away
wk.register({
    ["<leader>n"] = { "<cmd>:set hlsearch!<CR>", "Toggle Highlights" }
})

-- Toggleterm (Maybe no longer needed)
wk.register({
    ["<leader>t"] = { '<CMD>:lua require("FTerm").toggle()<CR>', "Toggle Floating Term" }
})


-- GOlang specific settings
wk.register({
    l = {
        name = "LSP",
        K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Documentation"},
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename Variable" },
        f = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format File" },


        g = {
            name = "GO",
            c = { "<cmd>:GoCmt<CR>", "Comment" },
            t = {
                name = "Tags",
                a = { "<cmd>:GoAddTag<CR>", "Add Tags" },
                r = { "<cmd>:GoRmTag<CR>", "Remove Tags" },
            },
            f = { "<cmd>:lua require('go.format').goimport()<CR>", "Fix Imports" },
        },
    },
}, { prefix = "<leader>" })

-- Debbuging --
wk.register({

    d = {
        name = "Debug",
        b = { "<Cmd>:lua require('dap').toggle_breakpoint()<CR>", "Breakpoint" },
        B = { "<Cmd>:lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
            "Breakpoint Condition" },
        p = { "<Cmd>:lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", "Log Point" },
        r = { "<Cmd>:lua require('dap').repl.open()<CR>", "Repl Open" },
        l = { "<Cmd>:lua require('dap').run_last()<CR>", "Run Last" },
    },
}, { prefix = "<leader>" })

-- GIT --
-- Undotree --
wk.register({
    ["<leader>u"] = {"<cmd>UndotreeToggle<CR>", "Toggle UndoTree" }
})
-- Harpoon --
wk.register({
    h = {
        name = "Harpoon",
        a = { "<cmd>:lua require('harpoon.mark').add_file()<CR>", "Add current file" },
        t = { "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle menu" },
        n = { "<cmd>:lua require('harpoon.ui').nav_next()<CR>", "Next item" },
        p = { "<cmd>:lua require('harpoon.ui').nav_prev()<CR>", "Previous item" },
        ['1'] = { "<cmd>:lua require('harpoon.ui').nav_file(1)<CR>", "Select File 1" },
        ['2'] = { "<cmd>:lua require('harpoon.ui').nav_file(2)<CR>", "Select File 2" },
        ['3'] = { "<cmd>:lua require('harpoon.ui').nav_file(3)<CR>", "Select File 3" },
        ['4'] = { "<cmd>:lua require('harpoon.ui').nav_file(4)<CR>", "Select File 4" },
    },
}, { prefix = "<leader>" })
-- Make Harpoon File 1 and 2 accessible from the main menue as well (1 less keypress)
wk.register({
    ["<leader>1"] = { "<cmd>:lua require('harpoon.ui').nav_file(1)<CR>", "Select File 1" },
    ["<leader>2"] = { "<cmd>:lua require('harpoon.ui').nav_file(2)<CR>", "Select File 2" }
})


--- DEBUGING
--wk.register({
--    <leader>d  = {
--        "name" = "Debugging"
--
