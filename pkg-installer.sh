#!/usr/bin/env fish

for pkg in (cat pkglist.txt)
    yay -S --neded $pkg
end
