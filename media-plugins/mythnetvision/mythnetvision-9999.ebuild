# Copyright 1999-2009 Gentoo Foundation
# Copyright 2005 Preston Crow
# Modifications by (Simon at Koala) from mythtv-dev list.
# Modifications by Marc Tousignant 2009
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
IUSE=""

DEPEND=">=sys-apps/sed-4
	>=media-tv/mythtv-${PV}[python]
	>=media-plugins/mythbrowser-${PV}
	www-plugins/adobe-flash
	>=dev-lang/python-2.5
	dev-python/feedparser
	dev-python/pycurl"

setup_pro() {
	return 0
}

src_configure() {
        return 0
}
