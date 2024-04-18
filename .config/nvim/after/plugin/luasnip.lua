local ls = require 'luasnip'
local types = require 'luasnip.util.types'
local snip = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local insert = ls.insert_node
local text = ls.text_node

ls.config.set_config{
    --This tells LuaSnip to remember to keep around the last snippe.
    -- You can jump back itno it even if you leave the selection
    history = true,

    -- This one letś you update stuff as you type
    updatevents = "TextChanged, TextChangedI",

    -- Autosnippets 
    enable_autosnippets = true,


    ext_opts = {
        [types.choiceNode] = {
            active = {
                virt_text = { { "<-", "Error" } },
            },
        },
    },
}
--create snippet
ls.add_snippets(nil, {
    all = {
        snip({
            trig = "swaggdoc",
        },{
            text("//nolint:all //only used for swagger documentation")
        }),
        snip({
            trig = "iea",
        },{
            text({"if err != nil{", "\tapp.serverErrorResponse(w, r, err)", "\treturn", "}"})
        }),
        snip({
            trig = "httpwr",
        },{
            text("w http.ResponseWriter, r *http.Request")
        }),
        snip({
            trig = "iet",
        },{
            text({"if err != nil{", "\tt.Fatal(err)", "}"})
        }),
    }
})



