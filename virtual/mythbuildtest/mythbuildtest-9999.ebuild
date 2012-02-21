# Copyright 1999-2009 Gentoo Foundation
# Copyright 2009-2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/mythtvlibs/mythtvlibs-0.18.ebuild

EAPI="3"
DESCRIPTION="Virtual for mythtv built testing"
HOMEPAGE="http://www.mythtv.org/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE=""
DEPEND=""
RDEPEND="=media-tv/mythtv-${PV}
	=x11-themes/mythtv-themes-${PV}
	=media-plugins/mythvideo-${PV}
	=media-plugins/mythzoneminder-${PV}
	=media-plugins/mytharchive-${PV}
	=media-plugins/mythmusic-${PV}
	=media-plugins/mythgame-${PV}
	=media-plugins/mythweather-${PV}
	=media-plugins/mythgallery-${PV}
	=media-plugins/mythbrowser-${PV}
	=media-plugins/mythnews-${PV}
	=media-plugins/mythnetvision-${PV}
	=www-apps/mythweb-${PV}"
