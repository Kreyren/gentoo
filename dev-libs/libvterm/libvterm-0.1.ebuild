# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit flag-o-matic

DESCRIPTION="An abstract library implementation of a VT220/xterm/ECMA-48 terminal emulator"
HOMEPAGE="http://www.leonerd.org.uk/code/libvterm/"
SRC_URI="https://launchpad.net/${PN}/trunk/v${PV}/+download/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

BDEPEND="
	dev-lang/perl
	sys-devel/libtool
	virtual/pkgconfig
"
DEPEND=""
RDEPEND="!dev-libs/libvterm-neovim"

src_prepare() {
	default
	# Remove broken test
	rm "t/63screen_resize.test" || die
}

src_compile() {
	append-cflags -fPIC
	emake VERBOSE=1 PREFIX="${EPREFIX}/usr" LIBDIR="${EPREFIX}/usr/$(get_libdir)"
}

src_install() {
	emake \
		VERBOSE=1 \
		PREFIX="${EPREFIX}/usr" \
		LIBDIR="${EPREFIX}/usr/$(get_libdir)" \
		DESTDIR="${D}" install
	find "${D}" -name '*.la' -delete || die "Failed to prune libtool files"
}
