function lt 
    pandoc --to=plain $argv | languagetool -l de-DE -
end
