
# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythstream/mythstream.ebuild,v 1.0 2009/08/02 20:46:49 Marc Tousignant Exp $

EAPI="2"

inherit qt4 myth-svn

DESCRIPTION="MythStream is an unofficial MythTV plugin that plays Internet audio and video streams."
HOMEPAGE="http://home.kabelfoon.nl/~moongies/streamtuned.html"
SRC_URI="http://home.kabelfoon.nl/~moongies/sw9vc4htz2/mythstream-0.18_qt4.tar.gz"

S=${WORKDIR}/"mythstream-0.18_qt4"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="media-video/mplayer
	dev-perl/XML-Simple
	dev-perl/XML-DOM
	dev-perl/XML-XQL
	=sci-libs/fftw-2*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/mythstream-parser-update.patch
	epatch "${FILESDIR}"/mythstream-0.18_qt4-mythtv_0_22.patch
	epatch "${FILESDIR}"/mythstream-0.18_qt4-apple_parser_fix.patch
	epatch "${FILESDIR}"/mythstream-0.18_qt4-streams_res.patch
	epatch "${FILESDIR}"/mythstream-0.18_qt4-youtube_parser_fix.patch
	qmake mythstream.pro
}

src_compile() {
	emake || die
}

src_install() {
#	emake PREFIX=/usr install || die
	myth-svn_src_install || die "install failed"
}

pkg_postinst() {
	return 0
}
