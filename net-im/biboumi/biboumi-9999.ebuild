# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

DESCRIPTION="Biboumi is an XMPP gateway that connects to IRC servers and translates between the two protocols"
HOMEPAGE="https://lab.louiz.org/louiz/biboumi"
EGIT_REPO_URI="git://git.louiz.org/biboumi.git"

LICENSE="zlib"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
dev-db/litesql
dev-libs/expat
net-dns/c-ares
net-dns/libidn
net-im/jabber-base
net-libs/botan
net-libs/udns
virtual/libiconv
"
RDEPEND="${DEPEND}"

inherit git-r3 cmake-utils

DIRS="/var/log/biboumi /var/lib/biboumi"

src_install() {
	default
	newinitd "${FILESDIR}/${PN}".initd "${PN}"
	for dir in $DIRS
	do
		keepdir $dir
	done

}

pkg_postinst() {
	for dir in $DIRS
	do
		chown jabber:jabber $dir
		chown 750 $dir
	done
}
