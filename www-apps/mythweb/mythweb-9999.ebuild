# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-9999.ebuild,v 1.3 2009/07/10 14:05:04 Marc Tousignant Exp $

inherit myth-svn webapp depend.php

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
ESVN_REPO_URI="http://cvs.mythtv.org/svn/trunk/mythplugins"
ESVN_PROJECT=mythplugins
ESVN_STORE_DIR="${DISTDIR}/svn-src"
_MODULE=${PN}
S="${WORKDIR}/${_MODULE}"
HOMEPAGE="http://www.mythtv.org/"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

RDEPEND="!dev-php/php
	!www-apps/mythweb-cvs"

pkg_setup() {
	webapp_pkg_setup

	require_php_with_use session mysql pcre posix json
}

src_compile() {
	return 0
}

src_install() {
	webapp_src_preinst

	rm -rf /var/tmp/mythweb
	mv ${S}/mythweb /var/tmp
	rm -rf ${S}/*
	mv /var/tmp/mythweb/* ${S}
	mv /var/tmp/mythweb/.htaccess ${S}

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
