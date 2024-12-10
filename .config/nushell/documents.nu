export def scan [] {
    sudo scanimage --format=pdf --output-file $"/mnt/files/Documents/Scans/(date now | format date "%FT%T").pdf" --progress
}
