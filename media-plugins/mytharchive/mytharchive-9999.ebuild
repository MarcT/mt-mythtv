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

DEPEND=">=sys-apps/sed-4
	>=dev-lang/python-2.3.5
	dev-python/mysql-python
	dev-python/imaging
	>=media-video/mjpegtools-1.6.2[png]
	>=media-video/dvdauthor-0.6.11
	>=media-video/ffmpeg-0.4.9
	>=app-cdr/dvd+rw-tools-5.21.4.10.8
	virtual/cdrtools
	media-video/transcode
	>=media-tv/mythtv-${PV}"

setup_pro() {
	return 0
}

src_configure() {
	epatch_user
        return 0
}
