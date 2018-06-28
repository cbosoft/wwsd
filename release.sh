# Put Updated PKGBUILD onto AUR
cp PKGBUILD ../wwsd-git/PKGBUILD
cd ../wwsd-git
git commit PKGBUILD
makepkg --printsrcinfo > .SRCINFO
git commit .SRCINFO
git push
