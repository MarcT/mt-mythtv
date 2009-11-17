# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/mythtvlibs/mythtvlibs-0.18.ebuild

DESCRIPTION="Virtual for mythtv built testing"
HOMEPAGE="http://www.mythtv.org/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""
DEPEND=""
RDEPEND="=media-tv/mythtv-${PV}
	>=x11-themes/mythtv-themes-graphite-1.0
	=x11-themes/mythtv-themes-${PV}
	=x11-themes/mythtv-themes-extra-${PV}
	=media-plugins/mythvideo-${PV}
	=media-plugins/mythmovies-${PV}
	=media-plugins/mythzoneminder-${PV}
	=media-plugins/mytharchive-${PV}
	=media-plugins/mythmusic-${PV}
	=media-plugins/mythgame-${PV}
	=media-plugins/mythweather-${PV}
	=media-plugins/mythgallery-${PV}
	=media-plugins/mythbrowser-${PV}
	=media-plugins/mythnews-${PV}"
