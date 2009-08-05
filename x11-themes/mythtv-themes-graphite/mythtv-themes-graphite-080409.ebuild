# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/mythtv-themes/mythtv-themes-graphite--072609.ebuild,v 1.3 2009/07/27 14:05:04 Marc Tousignant Exp $

MY_P="Graphite"

DESCRIPTION="MythTV Theme Graphite"
SRC_URI="http://www.fecitfacta.com/graphite.${PV}.tar.gz"
HOMEPAGE="http://www.fecitfacta.com/Graphite/"
SLOT="1"
LICENSE="CCA"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-tv/mythtv"

src_install() {
        dodir /usr/share/mythtv/themes
        insinto /usr/share/mythtv/themes
        doins -r ${MY_P}
        insinto /usr/share/mythtv/
}

