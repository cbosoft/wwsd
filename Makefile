clean:
	git clean -xdf

release:
	echo "$(cat buildno) + 1" | bc > buildno
	git commit buildno -m "Updated build number"
	git push
