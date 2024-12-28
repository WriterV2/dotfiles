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

export def search [--before: datetime, --after: datetime ] {
    open-db-in-memory
    let before_filter = if ($before != null) { 
        $before
    } else { 
        date now
    }

    let after_filter = if ($after != null) { 
        $after
    } else {
        "0001-01-01" | into datetime
    }

    let notes = open (get-db-path) | get note | where {|row|
        ($row.created | into datetime) < $before_filter and ($row.created | into datetime) > $after_filter
    }

    if ($notes | is-not-empty) {
        $notes | input list --fuzzy -d text 
    } else {
        "No notes found"
    }
}
