# Copyright 1999-2009 Gentoo Foundation
# Copyright 2009-2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mythtv-status/mythtv-status.ebuild,v 1.0 2009/08/02 20:46:49 Marc Tousignant Exp $

EAPI="3"

inherit git

DESCRIPTION="Places MythTV Status information in your MOTD"
HOMEPAGE="http://www.etc.gen.nz/projects/mythtv/mythtv-status.html"
EGIT_REPO_URI="http://git.etc.gen.nz/mythtv-status.git"
SRC_URI=""
EGIT_PATCHES="${FILESDIR}"/mythtv-status-mt.patch

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="dev-vcs/git[curl]
	dev-perl/Config-Auto
	dev-perl/Config-IniFiles
	dev-perl/libwww-perl
	dev-perl/XML-LibXML
	dev-perl/DateManip
	dev-perl/MIME-tools
	dev-perl/Net-UPnP"

src_unpack() {
	git_src_unpack
}

src_configure() {
        return 0
}

src_compile() {
        return 0
}

src_install() {
	insinto /usr
	dobin bin/*
	doman man/*

	exeinto /etc/cron.hourly
	doexe ${FILESDIR}/mythtv-status.cron

	insinto /etc/default
	doins ${FILESDIR}/mythtv-status
}

pkg_postinst() {
	elog
	elog "Be sure to modify /etc/default/mythtv-status to suit your needs."
	elog
}
