prep_deploy:
	makepkg
	makepkg --printsrcinfo > ../wwsd-git/.SRCINFO
	cp PKGBUILD ../wwsd-git/PKBGBUILD
	git clean -f
