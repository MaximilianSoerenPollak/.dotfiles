return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "go", "c", "python", "lua", "vim", "vimdoc", "query", "javascript", "html", "starlark" },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
