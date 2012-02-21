# Copyright 1999-2009 Gentoo Foundation
# Copyright 2005 Preston Crow
# Copyright 2009-2010 Marc Tousignant
# Modifications by (Simon at Koala) from mythtv-dev list.
# Modifications by Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit myth-git

DESCRIPTION="Gallery and slideshow module for MythTV."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug exif opengl"

DEPEND=">=sys-apps/sed-4
	opengl? ( virtual/opengl )
	exif? ( media-libs/libexif )
	media-libs/tiff
	>=media-tv/mythtv-${PV}"

setup_pro() {
        return 0
}

src_configure() {
	myconf="${myconf} $(use_enable exif) $(use_enable opengl)"
}
