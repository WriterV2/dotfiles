vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.tex",
    callback = function()
        -- compile tex file to pdf with pdflatex on save
        if vim.fn.executable('pdflatex') == 1 then
            vim.cmd("execute '!pdflatex ' . expand('%:p')")
        else
            print("pdflatex is not installed")
        end

        -- compile tex file to html with pandoc on save
        if vim.fn.executable('pandoc') == 1 then
            vim.cmd("execute '!pandoc -o ' . substitute(expand('%:p'), '.tex', '.html ', '') . expand('%:p')")
        else
            print("pandoc is not installed")
        end
    end,
})
