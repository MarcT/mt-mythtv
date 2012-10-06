# Copyright 1999-2009 Gentoo Foundation
# Copyright 2009-2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit myth-git

DESCRIPTION="RSS feed news reading module for MythTV."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	|| ( media-tv/mythtv[python] media-tv/mythtv-bindings[python] )
	dev-python/imaging
	"

DEPEND="
	media-video/mjpegtools[png]
	media-video/dvdauthor
	app-cdr/dvd+rw-tools
	virtual/cdrtools
	media-video/transcode
	"

setup_pro() {
	return 0
}

src_configure() {
	epatch_user
        return 0
}
