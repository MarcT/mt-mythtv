# Copyright 1999-2009 Gentoo Foundation
# Copyright 2009 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit myth-svn

DESCRIPTION="RSS feed news reading module for MythTV."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=sys-apps/sed-4
	minimal? ( dev-db/mysql
	www-misc/zoneminder )
	>=media-tv/mythtv-${PV}"

setup_pro() {
	return 0
}

src_configure() {
        return 0
}
