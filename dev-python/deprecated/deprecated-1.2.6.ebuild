# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_7,3_{5,6,7}} )
inherit distutils-r1

DESCRIPTION="Python @deprecated decorator to deprecate old API"
HOMEPAGE="https://github.com/tantale/deprecated"
SRC_URI="https://github.com/tantale/deprecated/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="dev-python/wrapt[${PYTHON_USEDEP}]"
BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		${RDEPEND}
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

python_test() {
	pytest -vv || die "Tests fail with ${EPYTHON}"
}
