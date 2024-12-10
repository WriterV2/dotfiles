export def upload [file: path] {
    let filename = ($file | path parse | get stem)
    let extension = ($file | path parse | get extension)
    curl 'http://10.11.99.1/upload' -H 'Origin: http://10.11.99.1' -H 'Referer: http://10.11.99.1/' -H 'Connection: keep-alive' -F $"file=@($file);filename=($filename);type=application/($extension)"
}
