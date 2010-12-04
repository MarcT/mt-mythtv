# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-9999.ebuild,v 1.3 2009/07/10 14:05:04 Marc Tousignant Exp $

EAPI="2"
inherit myth-git webapp depend.php

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
ESVN_REPO_URI="http://svn.mythtv.org/svn/branches/release-0-24-fixes/mythplugins"
ESVN_PROJECT=mythplugins
ESVN_STORE_DIR="${DISTDIR}/svn-src"
_MODULE=${PN}
S="${WORKDIR}/${_MODULE}"

[ -z "${MYTHTV_SVN_REVISION}" ] || ESVN_FETCH_CMD="svn checkout --revision ${MYTHTV_SVN_REVISION}"
[ -z "${MYTHTV_SVN_REVISION}" ] || ESVN_UPDATE_CMD="svn update --revision ${MYTHTV_SVN_REVISION}"

HOMEPAGE="http://www.mythtv.org/"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-perl/Math-Round
	>=dev-lang/php-5.3"

RDEPEND="!dev-php/php
	!www-apps/mythweb-cvs"

pkg_setup() {
	webapp_pkg_setup

	require_php_with_use session mysql posix json
}

src_compile() {
	return 0
}

src_install() {
	webapp_src_preinst

	rm -rf /var/tmp/mythweb
#	mv ${S}/mythweb /var/tmp
#	rm -rf ${S}/*
#	mv /var/tmp/mythweb/* ${S}
#	mv /var/tmp/mythweb/.htaccess ${S}

	keepdir ${MY_HTDOCSDIR}/video_dir
	keepdir ${MY_HTDOCSDIR}/image_cache
	keepdir ${MY_HTDOCSDIR}/php_sessions

	cp -R [[:lower:]]* .htaccess ${D}${MY_HTDOCSDIR}

	webapp_serverowned ${MY_HTDOCSDIR}/video_dir
	webapp_serverowned ${MY_HTDOCSDIR}/image_cache
	webapp_serverowned ${MY_HTDOCSDIR}/php_sessions

	webapp_postinst_txt en ${FILESDIR}/postinstall-en.txt

	webapp_src_install
}
