return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*",
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  config = function()
    local ls = require('luasnip')
    local types = require('luasnip.util.types')
    local snip = ls.snippet
    local text = ls.text_node

    -- Configure LuaSnip
    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      ext_opts = {
        [types.choiceNode] = {
          active = {
            virt_text = { { "<-", "Error" } },
          },
        },
      },
    })

    -- Add snippets
    ls.add_snippets(nil, {
      all = {
        snip({
          trig = "swaggdoc",
        }, {
          text("//nolint:all //only used for swagger documentation")
        }),
        snip({
          trig = "iea",
        }, {
          text({ "if err != nil{", "\tapp.serverErrorResponse(w, r, err)", "\treturn", "}" })
        }),
        snip({
          trig = "httpwr",
        }, {
          text("w http.ResponseWriter, r *http.Request")
        }),
        snip({
          trig = "iet",
        }, {
          text({ "if err != nil{", "\tt.Fatal(err)", "}" })
        }),
        snip({
          trig = "!html",
        }, {
          text({ '<!DOCTYPE html>', '<html lang="en">', '\t<head>',
            '\t\t<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />',
            '\t\t<meta name="description" content="" />', '\t\t<meta name="author" content="" />',
            '\t\t<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />',
            '\t\t<title></title>', '\t\t<link href="css/style.css" rel="stylesheet" />', '\t</head>', '<body>', '',
            '\t<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>',
            '</body>', '</html>' })
        }),
        snip({
          trig = "cpright",
        }, {
          text({ '# *******************************************************************************',
            '# Copyright (c) 2025 Contributors to the Eclipse Foundation', '#',
            '# See the NOTICE file(s) distributed with this work for additional',
            '# information regarding copyright ownership.', '#',
            '# This program and the accompanying materials are made available under the',
            '# terms of the Apache License Version 2.0 which is available at',
            '# https://www.apache.org/licenses/LICENSE-2.0', '#', '# SPDX-License-Identifier: Apache-2.0',
            '# *******************************************************************************' })
        })
      },
    })
  end,
}
