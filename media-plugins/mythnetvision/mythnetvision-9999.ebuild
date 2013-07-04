# Copyright 1999-2009 Gentoo Foundation
# Copyright 2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit myth-git

DESCRIPTION="NetVision module for MythTV."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="media-tv/mythtv[python]
        dev-python/mysql-python
	dev-python/pycurl
	dev-python/oauth
        dev-python/lxml"

DEPEND=""

setup_pro() {
	return 0
}

src_configure() {
        return 0
}
