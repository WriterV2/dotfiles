-- compile tex file to pdf with pdflatex on save
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.tex",
    callback = function()
        if vim.fn.executable('pdflatex') == 1 then
            vim.cmd("execute '!pdflatex' . ' ' . expand('%:p')")
        else
            print("pdflatex is not installed")
        end
    end,
})
