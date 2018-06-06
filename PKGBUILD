# Maintainer: Chris Boyle <christopher.boyle.101 at strath dot ac dot uk>
pkgname=wwsd-git
pkgver=r20.60548b6
pkgrel=1

pkgdesc="WWSd: i3 workspace wallpaper setter daemon"
arch=('any')
url="https://github.com/cbosoft/wwsd"
license=('MIT')

groups=()
depends=('python' 'python-docopt' 'nitrogen' 'i3-wm')
makedepends=('git')

source=("${pkgname}::git+https://github.com/cbosoft/wwsd.git#branch=master")

md5sums=('SKIP')

pkgver() {
    cd "${srcdir}/${pkgname}"
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
}

package() {
    cd "${srcdir}"
    # python script
    install -vDm 755 "${pkgname}/wwsd" "${pkgdir}/usr/bin/wwsd"
}
