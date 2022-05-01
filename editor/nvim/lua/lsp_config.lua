vim.lsp.set_log_level(4)

-- show diagnostic messages in quickfix list with <M-q>
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = { border = 'single' },
})
vim.keymap.set("n", "<M-q>", function() toggle_diagnostics_qflist() end)

-- toggle quickfix list
function toggle_diagnostics_qflist()
    local windows = vim.fn.getwininfo()
    local qf_opened = false
    for i = 1, vim.fn.len(windows), 1 do
        local window = windows[i]
        if window.quickfix == 1 then qf_opened = true end
    end
    if qf_opened then
        vim.cmd(":cclose")
    else
        vim.diagnostic.setqflist()
    end
end

-- setup and config nvim-cmp completion
local cmp = require("cmp")
cmp.register_source("nvim_lsp_signature_help", require("cmp_nvim_lsp_signature_help").new())

cmp.setup({
    -- set vim-vsnip as snippet engine for nvim-cmp completion
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Down>'] = cmp.mapping.scroll_docs(4),
        ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
    },
    -- complete based on LSP, Snippets and Buffer
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Jump forward or backward to snippet placeholders in insert mode
vim.api.nvim_set_keymap("i", "<C-l>", "<Plug>(vsnip-jump-next)", { noremap = false })
vim.api.nvim_set_keymap("s", "<C-l>", "<Plug>(vsnip-jump-next)", { noremap = false })
vim.api.nvim_set_keymap("i", "<C-h>", "<Plug>(vsnip-jump-prev)", { noremap = false })
vim.api.nvim_set_keymap("s", "<C-h>", "<Plug>(vsnip-jump-prev)", { noremap = false })


-- complete text in search based on buffer
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- compete path in commandline
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),

})

-- add additional completion capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lspconfig = require("lspconfig")

-- attaches settings after language server attaches to current buffer
local on_attach = function(client, bufnr)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
            vim.lsp.buf.formatting_seq_sync()
        end,
    })

end

-- Language Servers
lspconfig['rust_analyzer'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust_analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        },
    },
}
lspconfig['bashls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig['pylsp'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig['html'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig['cssls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig['texlab'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig['svelte'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig['eslint'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig['jsonls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}
lspconfig['sumneko_lua'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim", "on_attach" }
            }
        }
    }
}
