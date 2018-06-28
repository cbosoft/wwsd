# Update MD5
sed -i "17s/.*/md5sums=($(md5sum wwsd | cut -d' ' -f 1))/" PKGBUILD
git commit PKGBUILD -m "Updated md5sum"

# Increment 'build' number
echo "$(cat buildno) + 1" | bc > buildno
git commit buildno -m "Updated 'build' number"

# Push to github
git push

# Put Updated PKGBUILD onto AUR
cp PKGBUILD ../wwsd-git/PKGBUILD
cd ../wwsd-git
git commit PKGBUILD
