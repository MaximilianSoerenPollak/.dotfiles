return require('packer').startup(function()
    -- Packer can manage itself

    use("wbthomason/packer.nvim")
    use("rebelot/kanagawa.nvim")
    use { "rose-pine/neovim", as = "rose-pine" }
    use { 'RRethy/nvim-base16', as = 'base16' }
    use { 'nyoom-engineering/oxocarbon.nvim' }
    use { "folke/tokyonight.nvim" }
    use({
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        requires = {
            "nvim-lua/plenary.nvim",
        },
    })
    use { 'frenzyexists/aquarium-vim', as = 'aquarium' }
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("onsails/lspkind.nvim")
    use { "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "typescript-language_server",
                "golangci-lint"
            }
        }
    }
    use { "williamboman/mason-lspconfig.nvim" }
    use("neovim/nvim-lspconfig")
    -- use ("tamago324/nlsp-settings.nvim")
    use({ "nvimtools/none-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("null-ls").setup({
                sources = {
                    require("null-ls").builtins.formatting.stylua,
                    require("null-ls").builtins.completion.spell,
                    require("null-ls").builtins.diagnostics.golangci_lint,
                    require("null-ls").builtins.diagnostics.actionlint,
                    require("null-ls").builtins.diagnostics.checkmake
                },
            })
        end
    })
    use('wakatime/vim-wakatime')
    use('ThePrimeagen/harpoon')
    use { "nvim-telescope/telescope.nvim",
        requires = { { 'nvim-lua/plenary.nvim' } } }
    use {
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup({
            })
        end
    }
    use { "folke/trouble.nvim",requires = { "nvim-tree/nvim-web-devicons" }}
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

    use("mfussenegger/nvim-dap")
    use("mfussenegger/nvim-dap-python")
    use { "nvim-neotest/nvim-nio" }
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap","nvim-neotest/nvim-nio" } })
    use("theHamsta/nvim-dap-virtual-text")
    use('leoluz/nvim-dap-go')
    use('nvim-telescope/telescope-dap.nvim')
    use('mbbill/undotree')
    use { "zootedb0t/citruszest.nvim" }

end)
