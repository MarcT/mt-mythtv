# Copyright 1999-2009 Gentoo Foundation
# Copyright 2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit myth-git

DESCRIPTION="NetVision module for MythTV."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=sys-apps/sed-4
	>=media-tv/mythtv-${PV}[python]
	>=media-plugins/mythbrowser-${PV}
	www-plugins/adobe-flash
	>=dev-lang/python-2.5
	dev-python/feedparser
	dev-python/oauth
	dev-python/pycurl"

setup_pro() {
	return 0
}

src_configure() {
        return 0
}
