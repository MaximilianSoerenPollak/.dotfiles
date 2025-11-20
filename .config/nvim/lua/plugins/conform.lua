return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      xml = { "xmlformatter" },
      -- Conform will run multiple formatters sequentially
      python = { "ruff_format" },
      go = { "gofmt" },
      bzl = { "buildifier" },
      BUILD = { "buildifier" },
      markdown = { "mdformat" },
      bazel = { "buildifier" },
      rst = { "rstfmt" },
    },
  },
}
