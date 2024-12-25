def open-db-in-memory [] {
    if (get-db-path | path exists) {
        stor import --file-name (get-db-path)
    } else {
        stor reset
        stor create -t "note" -c {created: datetime, text: str}
        stor export --file-name (get-db-path)
    }
}

def save-db-to-file [] {
    rm (get-db-path)
    stor export --file-name (get-db-path)
}

def get-db-path [] {
    $env.HOME + "/.config/nushell/notes.db"
}

export def add [text: string] {
    open-db-in-memory
    stor insert -t note -d { created: (date now), text: ($text) }
    save-db-to-file
}

export def search [] {
    open-db-in-memory
    open (get-db-path) | get note | input list --fuzzy -d text 
}
