# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit bash-completion-r1 systemd user

DESCRIPTION="Main implementation of IPFS"
HOMEPAGE="https://ipfs.io/"
SRC_URI="amd64? ( https://dist.ipfs.io/go-ipfs/v${PV}/go-ipfs_v${PV}_linux-amd64.tar.gz )
	x86? ( https://dist.ipfs.io/go-ipfs/v${PV}/go-ipfs_v${PV}_linux-386.tar.gz )
	arm? ( https://dist.ipfs.io/go-ipfs/v${PV}/go-ipfs_v${PV}_linux-arm.tar.gz )

	https://raw.githubusercontent.com/ipfs/go-ipfs/v${PV}/misc/completion/ipfs-completion.bash -> ${P}.bash"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm ~x86"

RDEPEND="sys-fs/fuse"
S="${WORKDIR}/go-ipfs"

QA_PREBUILT="/usr/bin/ipfs"

src_install() {
	dobin ipfs

	systemd_dounit "${FILESDIR}/ipfs.service"
	newinitd "${FILESDIR}/ipfs.init" ipfs
	newconfd "${FILESDIR}/ipfs.confd" ipfs

	newbashcomp "${DISTDIR}/${P}.bash" "ipfs"
	keepdir /var/log/ipfs
}

pkg_preinst() {
	enewgroup ipfs
	enewuser ipfs "" "" /var/lib/ipfs ipfs

	fowners -R ipfs:ipfs /var/log/ipfs
}

pkg_postinst() {
	elog 'To be able to use the ipfs service you will need to create the ipfs repository'
	elog '(eg: su -s /bin/sh -c "ipfs init -e" ipfs)'
	elog 'or change IPFS_PATH of /etc/conf.d/ipfs with another with proper permissions.'
}
