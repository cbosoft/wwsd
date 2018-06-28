# Maintainer: Chris Boyle <christopher.boyle.101 at strath dot ac dot uk>
pkgname=wwsd-git
pkgver=1
pkgrel=1

pkgdesc="Sets wallpaper depending on user-set rules"
arch=('any')
url="https://github.com/cbosoft/wwsd"
license=('MIT')

groups=()
depends=('python' 'python-docopt' 'nitrogen' 'i3-wm' 'i3ipc-python')
makedepends=('git')

source=(wwsd)

md5sums=(ce7c4b259cc72afcd88ebd221ba40ed9)

pkgver() {
    echo 1
}

package() {
    install -vDm 755 "wwsd" "${pkgdir}/usr/bin/wwsd"
}
