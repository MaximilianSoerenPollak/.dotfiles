return {
  "neovim/nvim-lspconfig",
  dependencies = { 'saghen/blink.cmp' },

  -- example using `opts` for defining servers
  opts = {
    servers = {
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              useLibraryCodeForTypes = true,
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              -- Correct location for inlay hints in basedpyright
              inlayHints = {
                variableTypes = false,
                functionReturnTypes = false,
                callArgumentNames = false,
                genericTypes = false,
              }
            }
          }
        }
      },
      bashls = {},
      lua_ls = {},
      starpls = {
        filetypes = { "star", "bzl", "BUILD.bazel", "BUILD" },
      },
      esbonio = {},
      ruff = {
        root_dir = function(fname)
          local lspconfig = require('lspconfig')
          local root = lspconfig.util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', '.git')(fname)
          -- Optional: uncomment to debug root directory detection
          -- print("Ruff root directory:", root)
          return root
        end,
        init_options = {
          settings = {
            -- Ruff will automatically pick up pyproject.toml configuration
            args = {},
          }
        }
      },
      tailwindcss = {
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
        filetypes = { "html", "templ", "gohtmltmpl", "gohtml", "tmpl" }
      },

    }
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')

    local function on_attach(client, bufnr)
      vim.diagnostic.config({
        virtual_text = true, -- Enable this to see if diagnostics are being received
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Simple approach for basedpyright - just disable on attach
      if client.name == "basedpyright" then
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
      end

      local bufmap = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
      end

      bufmap('n', 'gd', vim.lsp.buf.definition, "Go to Definition")
      bufmap('n', 'K', vim.lsp.buf.hover, "Hover Info")
      bufmap('n', '<leader>rn', vim.lsp.buf.rename, "Rename Symbol")
      bufmap('n', 'gr', vim.lsp.buf.references, "Find References")
      bufmap('n', '<leader>ca', vim.lsp.buf.code_action, "Code Action")
    end

    for server, config in pairs(opts.servers) do
      -- passing config.capabilities to blink.cmp merges with the capabilities in your
      -- `opts[server].capabilities, if you've defined it
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      config.on_attach = config.on_attach or on_attach
      lspconfig[server].setup(config)
    end
  end
}
