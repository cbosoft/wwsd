# Update MD5
sed -i "17s/.*/md5sums=($(md5sum wwsd | cut -d' ' -f 1))/" PKGBUILD

# Increment 'build' number
echo "$(cat buildno) + 1" | bc > buildno
