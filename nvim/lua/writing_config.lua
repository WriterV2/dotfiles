-- compile tex file to pdf with pdflatex on save
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.tex",
    callback = function()
        vim.cmd("execute '!pdflatex' . ' ' . expand('%:p')")
    end,
})
