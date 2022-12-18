vim.lsp.set_log_level(4)

-- show diagnostic messages in quickfix list with <M-q>
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = { border = 'single' },
})
vim.keymap.set("n", "<M-q>", function()
    -- toggle quickfix list
    local windows = vim.fn.getwininfo()
    local qf_opened = false
    for i = 1, #windows, 1 do
        local window = windows[i]
        if window.quickfix == 1 then
            qf_opened = true
            break
        end
    end
    if qf_opened then
        vim.api.nvim_command("cclose")
    else
        vim.diagnostic.setqflist()
    end
end)

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
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require("lspconfig")

-- attaches settings after language server attaches to current buffer
local on_attach = function()
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end)
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
            vim.lsp.buf.format {
                async = false
            }
        end,
    })

end

-- Language Servers

-- Rust
lspconfig['rust_analyzer'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy"
            },
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

-- Bash
lspconfig['bashls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Python
lspconfig['jedi_language_server'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- HTML
lspconfig['html'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- CSS
lspconfig['cssls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Tex
lspconfig['texlab'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Svelte
lspconfig['svelte'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Typescript & Javascript
lspconfig['tsserver'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "typescript", "javascript" },
}

-- JSON
lspconfig['jsonls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Lua
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

-- Java
lspconfig['java_language_server'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "/usr/share/java/java-language-server/lang_server_linux.sh" },
}

-- C lang
lspconfig['clangd'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
}


-- show nvim-lsp progress
require "fidget".setup {}