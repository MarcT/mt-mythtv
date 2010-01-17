# Copyright 1999-2009 Gentoo Foundation
# Copyright 2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit myth-svn

DESCRIPTION="NetVision module for MythTV."
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

pkg_setup() {
	ewarn
	ewarn "Add the following to library.xml in defaultmenu: "
	ewarn 
	ewarn "    <button>"
	ewarn "        <type>NET_VIDEO_SEARCH</type>"
	ewarn "        <text>Search Internet Video</text>"
	ewarn "        <description>Search popular video sites</description>"
	ewarn "        <action>JUMP MythNetVision</action>"
	ewarn "        <depends>mythnetvision</depends>"
	ewarn "    </button>"
	ewarn
	ewarn "    <button>"
	ewarn "        <type>NET_VIDEO_TREE</type>"
	ewarn "        <text>Browse Internet Video</text>"
	ewarn "        <description>Browse highlights and entire sites</description>"
	ewarn "        <action>JUMP MythNetTree</action>"
	ewarn "        <depends>mythnetvision</depends>"
	ewarn "    </button>"
	ewarn
}

setup_pro() {
	return 0
}

src_configure() {
        return 0
}
