-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"


-- ORGANIZE THE PLUGINS / CLEAN HOUSE
-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- Colorschemes
        { "rebelot/kanagawa.nvim" },
        {
            "gambhirsharma/vesper.nvim",
            lazy = false,
            priority = 1000,
            name = "vesper",
            config = function ()
                vim.cmd([[colorscheme vesper]])
            end
        },
        { 'cryptomilk/nightcity.nvim', version = '*' },
        { 'glepnir/zephyr-nvim' },
        { 'Yazeed1s/oh-lucy.nvim' },
        {
            "vague2k/vague.nvim",
            config = function()
                require("vague").setup({
                    -- optional configuration here
                })
            end
        },
        { "rose-pine/neovim",                 name = "rose-pine" },
        { 'RRethy/nvim-base16',               name = 'base16' },
        { 'nyoom-engineering/oxocarbon.nvim' },
        { "folke/tokyonight.nvim" },
        { 'frenzyexists/aquarium-vim',        name = 'aquarium' },
        { "zootedb0t/citruszest.nvim" },
        {
            "ilof2/posterpole.nvim",
            priority=1000,
            config = function ()
                require("posterpole").setup({
                    -- config here
                })
                vim.cmd("colorscheme posterpole")

                -- if you need colorscheme without termguicolors support
                -- This variant set termguicolors to false, be aware of using it
                -- vim.cmd("colorscheme posterpole-term")
            end
        },
        { "diegoulloao/neofusion.nvim", priority = 1000},
        {
            'shawilly/ponokai',
            lazy = false,
            priority = 1000
        },

        -- Essential
        { "nvim-lua/plenary.nvim" },

        -- LSP 
        { "onsails/lspkind.nvim" },
        { "williamboman/mason.nvim" },
        {
            'neovim/nvim-lspconfig',
            dependencies = { 'saghen/blink.cmp' },

            -- example using `opts` for defining servers
            opts = {
                servers = {
                    lua_ls = {}
                }
            },
            config = function(_, opts)
                local lspconfig = require('lspconfig')
                for server, config in pairs(opts.servers) do
                    -- passing config.capabilities to blink.cmp merges with the capabilities in your
                    -- `opts[server].capabilities, if you've defined it
                    config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
                    lspconfig[server].setup(config)
                end
            end

            -- example calling setup directly for each LSP
            config = function()
                local capabilities = require('blink.cmp').get_lsp_capabilities()
                local lspconfig = require('lspconfig')

                lspconfig['lua_ls'].setup({ capabilities = capabilities })
            end
        },
        { "neovim/nvim-lspconfig" },
        { "nvimtools/none-ls.nvim",           dependencies = { "nvim-lua/plenary.nvim" } },

        -- Intelisense / Treesitter / Autocomplete stuff
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            config = function()
                local configs = require("nvim-treesitter.configs")
                configs.setup({
                    ensure_installed = { "go", "c", "python", "lua", "vim", "vimdoc", "query", "javascript", "html" },
                    sync_install = false,
                    highlight = { enable = true },
                    indent = { enable = true },
                })
            end
        },
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "saadparwaiz1/cmp_luasnip" },
        {
            'saghen/blink.cmp',

            -- use a release tag to download pre-built binaries
            version = '*',
            ---@module 'blink.cmp'
            ---@type blink.cmp.Config
            opts = {
                -- 'default' for mappings similar to built-in completion
                -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
                -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
                -- See the full "keymap" documentation for information on defining your own keymap.
                keymap = { preset = 'default' },

                appearance = {
                    -- Sets the fallback highlight groups to nvim-cmp's highlight groups
                    -- Useful for when your theme doesn't support blink.cmp
                    -- Will be removed in a future release
                    use_nvim_cmp_as_default = true,
                    -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
                    -- Adjusts spacing to ensure icons are aligned
                    nerd_font_variant = 'mono'
                },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },
            },
            opts_extend = { "sources.default" }
        },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },

        -- Debuging
        { "mfussenegger/nvim-dap" },
        { "mfussenegger/nvim-dap-python" },
        { "rcarriga/nvim-dap-ui",             dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
        { "theHamsta/nvim-dap-virtual-text" },
        { 'leoluz/nvim-dap-go' },
        { 'nvim-telescope/telescope-dap.nvim' },

        -- Navigation 
        { 'ThePrimeagen/harpoon' },
        { "nvim-telescope/telescope.nvim", dependencies = { 'nvim-lua/plenary.nvim' } },

        -- Language Specific
        --  GO
        {
            "ray-x/go.nvim",
            dependencies = { -- optional packages
                "ray-x/guihua.lua",
                "neovim/nvim-lspconfig",
                "nvim-treesitter/nvim-treesitter",
            },
            config = function()
                require("go").setup()
            end,
            event = { "CmdlineEnter" },
            ft = { "go", 'gomod' },
            build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
        },
        -- Tailwind 
        {
            "luckasRanarison/tailwind-tools.nvim",
            name = "tailwind-tools",
            build = ":UpdateRemotePlugins",
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
                "nvim-telescope/telescope.nvim", -- optional
                "neovim/nvim-lspconfig", -- optional
            },
            opts = {} -- your configuration
        },
        -- Markdown 
        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            ft = { "markdown" },
            build = function() vim.fn["mkdp#util#install"]() end,
        },
        -- LaTeX 
        {
            "lervag/vimtex",
            lazy = false, -- we don't want to lazy load VimTeX
            -- tag = "v2.15", -- uncomment to pin to a specific release
            init = function()
                -- VimTeX configuration goes here, e.g.
                vim.g.vimtex_view_method = "zathura"
            end
        },

        -- Snippets
        { "L3MON4D3/LuaSnip" },

        -- MISC stuff
        { 'wakatime/vim-wakatime' },
        { "numToStr/Comment.nvim",         lazy = "Comment" },
        { "nvchad/showkeys", cmd = "ShowkeysToggle", opts={  position = "top-right"}},
        { "folke/zen-mode.nvim",           opts = { width = 250 } },
        {
            "kylechui/nvim-surround",
            version = "*", -- Use for stability; omit to use `main` branch for the latest features
            event = "VeryLazy",
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to use defaults
                })
            end
        },
        {
            "folke/which-key.nvim",
            event = "VeryLazy",
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            },
        },
        { 'mbbill/undotree' },
        { "folke/trouble.nvim",            dependencies = { "nvim-tree/nvim-web-devicons" } },
        { "LudoPinelli/comment-box.nvim" },


        -- Nicer UI
        { "rcarriga/nvim-notify" },
        { "kyazdani42/nvim-web-devicons" },
        { "nvchad/volt"},

        -- GIT -
        { "lewis6991/gitsigns.nvim" },

        -- Lines
        { "nvim-lualine/lualine.nvim" },
        { "akinsho/bufferline.nvim" },

    },

    -- We don't want to always get information for new versions
    checker = { enabled = false },
})
