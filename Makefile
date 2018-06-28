clean:
	git clean -xdf

release:
	sed -i "17s/.*/md5sums=($(md5sum wwsd | cut -d' ' -f 1))/" PKGBUILD
	git commit PKGBUILD -m "Updated md5sum"
	echo "$(cat buildno) + 1" | bc > buildno
	git commit buildno -m "Updated build number"
	git push
