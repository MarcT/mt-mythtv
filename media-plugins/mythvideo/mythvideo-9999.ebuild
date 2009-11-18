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

DESCRIPTION="Video player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-apps/sed-4
	sys-apps/eject
	>=media-tv/mythtv-${PV}"

RDEPEND="${DEPEND}
	 dev-perl/libwww-perl
	 dev-perl/HTML-Parser
	 dev-perl/URI
	 dev-perl/XML-Simple
	 dev-python/mysql-python
	 dev-python/imdbpy
	 dev-python/imaging
	 dev-python/lxml
	 || ( media-video/xine-ui media-video/mplayer )"

setup_pro() {
	return 0
}
