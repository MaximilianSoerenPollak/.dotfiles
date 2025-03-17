return {
    "neovim/nvim-lspconfig",
    dependencies = { 'saghen/blink.cmp' },

    -- example using `opts` for defining servers
    opts = {
        servers = {
            pyright = {},
            bashls = {},
            lua_ls = {},
            tailwindcss = {
                on_attach = on_attach,
                capabilities = capabilities,
                filetypes = { "templ", "astro", "javascript", "typescript", "react" },
                settings = {
                    tailwindCSS = {
                        includeLanguages = {
                            templ = "html",
                        },
                    },
                },
            },
            gopls = {     
                cmd = { "gopls", "serve" },
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                    },
                },
            },
            html = {
                filetypes = {"html", "templ", "gohtmltmpl", "gohtml", "tmpl"}
            },

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
}
