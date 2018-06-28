# Put Updated PKGBUILD and .SRCINFO onto AUR
cp PKGBUILD ../wwsd-git/PKGBUILD
cd ../wwsd-git
makepkg --printsrcinfo > .SRCINFO
git commit PKGBUILD .SRCINFO
git push
