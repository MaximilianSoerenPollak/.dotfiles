-- Only required if you have packer configured as `opt`

return require('packer').startup(function()
    -- Packer can manage itself

    use("wbthomason/packer.nvim")
    use("Almo7aya/neogruvbox.nvim")
    use("rebelot/kanagawa.nvim")
    use { "rose-pine/neovim", as = "rose-pine" }
    use { 'NLKNguyen/papercolor-theme', as = 'papercolor' }
    use { 'RRethy/nvim-base16', as = 'base16' }
    use { "folke/tokyonight.nvim" }
    use { "embark-theme/vim", as = 'embark' }
    use { 'Yazeed1s/oh-lucy.nvim', as = 'lucy' }
    use { "savq/melange-nvim", as = 'melange' }
    use { "catppuccin/nvim", as = "catppuccin" }
    use { "zSnails/cityscape.nvim" }
    use { "iagorrr/noctishc.nvim" }
    use { 'frenzyexists/aquarium-vim', as = 'aquarium' }
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("onsails/lspkind.nvim")
    use { "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "eslint-lsp",
                "prettier",
                "typescript-language_server"
            }
        }
    }
    use { "williamboman/mason-lspconfig.nvim" }
    use("neovim/nvim-lspconfig")
    -- use ("tamago324/nlsp-settings.nvim")
    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })
    use('wakatime/vim-wakatime')
    use('ThePrimeagen/harpoon')
    use("numToStr/FTerm.nvim")
    use("rktjmp/lush.nvim")
    use { "nvim-telescope/telescope.nvim",
        requires = { { 'nvim-lua/plenary.nvim' } } }
    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
            })
        end
    }
    use { "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }
    use('ray-x/go.nvim',
        require('go').setup())
    use("rcarriga/nvim-notify")
    use("kyazdani42/nvim-web-devicons")
    use("L3MON4D3/LuaSnip")
    use("hrsh7th/cmp-nvim-lsp")
    use("saadparwaiz1/cmp_luasnip")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("max397574/lua-dev.nvim")
    use { "nvim-treesitter/nvim-treesitter",
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "markdown", "markdown_inline" },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { "markdown" },
            },
        }) }
    -- GIT --
    use("lewis6991/gitsigns.nvim")
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

    use { "max397574/which-key.nvim" }
    use("nvim-lualine/lualine.nvim")
    use({
        "iamcco/markdown-preview.nvim",
        run = "cd app && npm install",
        setup = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        ft = { "markdown" },
    })
    use("akinsho/bufferline.nvim")
    use("hrsh7th/nvim-cmp")
    use("akinsho/toggleterm.nvim")
    -- neorg stuff

    -- Debuging
    --   use {
    --   "mfussenegger/nvim-dap",
    --   opt = true,
    --   event = "BufReadPre",
    --   module = { "dap" },
    --   wants = { "nvim-dap-virtual-text", "DAPInstall.nvim", "nvim-dap-ui", "nvim-dap-python", "which-key.nvim" },
    --   requires = {
    --     "Pocco81/DAPInstall.nvim",
    --     "theHamsta/nvim-dap-virtual-text",
    --     "rcarriga/nvim-dap-ui",
    --     "mfussenegger/nvim-dap-python",
    --     "nvim-telescope/telescope-dap.nvim",
    --     { "leoluz/nvim-dap-go", module = "dap-go" },
    --     { "jbyuki/one-small-step-for-vimkind", module = "osv" },
    --   },
    --   config = function()
    --     require("config.dap").setup()
    --   end,
    -- }
    use("mfussenegger/nvim-dap")
    use("mfussenegger/nvim-dap-python")
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use("theHamsta/nvim-dap-virtual-text")
    use('leoluz/nvim-dap-go')
    use('nvim-telescope/telescope-dap.nvim')
    use('mbbill/undotree')
end)
