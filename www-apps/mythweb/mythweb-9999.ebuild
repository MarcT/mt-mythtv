# Copyright 1999-2009 Gentoo Foundation
# Copyright 2009-2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/mythweb/mythweb-9999.ebuild,v 1.3 2009/07/10 14:05:04 Marc Tousignant Exp $

EAPI="3"
inherit myth-git webapp depend.php

DESCRIPTION="PHP scripts intended to manage MythTV from a web browser."
HOMEPAGE="http://www.mythtv.org/"
IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

DEPEND="dev-perl/Math-Round"

RDEPEND="!dev-php/php
	!www-apps/mythweb-cvs
	>=dev-lang/php-5.3
	<dev-lang/php-5.4[curl,json,mysql,session,posix]
	|| ( <dev-lang/php-5.3[spl,pcre] <dev-lang/php-5.4 )"


pkg_setup() {
	webapp_pkg_setup

	require_php_with_use session mysql posix json
}

src_compile() {
	return 0
}

src_install() {
	webapp_src_preinst

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
