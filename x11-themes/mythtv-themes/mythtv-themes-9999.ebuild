# Copyright 1999-2009 Gentoo Foundation
# Copyright 2009-2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-9999.ebuild,v 1.3 2009/07/10 14:05:04 Marc Tousignant Exp $

EAPI="3"
inherit myth-git

DESCRIPTION="A collection of themes for the MythTV project."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND=">=media-tv/mythtv-${PV}"

#S=${WORKDIR}

src_unpack() {
        myth-git_src_unpack
        cd ${S}
}



src_install() {

        find "${S}" -type f -print0 | xargs -0 chmod 644
        find "${S}" -type d -print0 | xargs -0 chmod 755

        dodir /usr/share/mythtv
        einfo "               -- Ignore these errors --                "
        einfo " Cleaning the build folder to avoid possible collisions "
        rm ${S}/*
        cp -r "${S}" "${D}/usr/share/mythtv/themes"
	if [ -a "${S}/Arclight" ] ; then
		dodir /usr/share/fonts/Arclight
		cp -r "${S}/Arclight/CartoGothicStd-Book.otf" "${D}/usr/share/fonts/Arclight"
		cp -r "${S}/Arclight/League Gothic.otf" "${D}/usr/share/fonts/Arclight"
	fi
}

pkg_postinst() {
	if [ -a "${S}/Arclight" ] ; then
		einfo "Installing Arclight Fonts"
		fc-cache -f
	fi
}
