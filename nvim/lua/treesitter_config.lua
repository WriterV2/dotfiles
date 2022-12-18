require("nvim-treesitter.configs").setup {
    ensure_installed = { "rust", "bash", "c", "comment", "cpp", "css", "dockerfile", "fish", "gdscript", "gitignore",
        "glsl", "go", "haskell", "help", "html", "http", "java", "javascript", "json", "kotlin", "latex", "llvm", "lua",
        "make", "markdown", "pascal", "python", "regex", "scss", "sql", "svelte", "toml", "typescript", "vim", "vue",
        "yaml" },
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
    }
}
