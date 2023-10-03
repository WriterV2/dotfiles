function remarkable_upload
    set filetype (string split . $argv)[2]
    curl 'http://10.11.99.1/upload' -H 'Origin: http://10.11.99.1' -H 'Referer: http://10.11.99.1/' -H 'Connection: keep-alive' -F "file=@$argv;filename=$argv;type=application/$filetype"
end
