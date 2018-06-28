# Put Updated PKGBUILD and .SRCINFO onto AUR
makepkg
cp PKGBUILD ../wwsd-git/PKGBUILD
cd ../wwsd-git
makepkg --printsrcinfo > .SRCINFO
git clean -xdf
git commit PKGBUILD .SRCINFO
git push
