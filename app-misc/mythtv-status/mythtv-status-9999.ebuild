# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logrotate/logrotate-3.7.8.ebuild,v 1.9 2009/07/02 19:36:10 maekke Exp $

EAPI="2"

inherit git

DESCRIPTION="Places MythTV Status information in your MOTD"
HOMEPAGE="http://www.etc.gen.nz/projects/mythtv/mythtv-status.html"
EGIT_REPO_URI="http://git.etc.gen.nz/mythtv-status.git"
SRC_URI=""
EGIT_PATCHES="${FILESDIR}"/mythtv-status-mt.patch


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="selinux"

DEPEND="dev-perl/libwww-perl
	dev-perl/XML-LibXML
	dev-perl/DateManip
	dev-perl/MIME-tools"

src_unpack() {
	git_src_unpack
	git_apply_patches
}


src_prepare() {
	strip-flags
}

src_configure() {
	return
}

src_compile() {
	return 0
}

src_install() {
	insinto /usr
	dobin bin/mythtv-status
	dobin bin/mythtv-update-motd

	exeinto /etc/cron.hourly
	doexe ${FILESDIR}/mythtv-status.cron
}

pkg_postinst() {
	elog
	elog "If this machine is not your backend you need to edit"
	elog "/usr/bin/mythtv-update-motd and change $HOST to the"
	elog " name/ip of your backend."
	elog
}
