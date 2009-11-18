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

DESCRIPTION="Music player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="opengl sdl X aac libvisual"

DEPEND=">=media-libs/taglib-1.4
	>=media-sound/cdparanoia-3.9.8
	>=media-libs/libmad-0.15.1b
	>=media-libs/libid3tag-0.15.1b
	>=media-libs/libvorbis-1.0
	>=media-libs/libcdaudio-0.99.6
	>=media-libs/flac-1.1.2
	>=media-libs/taglib-1.4
	>=sys-apps/sed-4
	aac? ( >=media-libs/faad2-2.0-r7 )
	fftw? ( sci-libs/fftw )
	opengl? ( virtual/opengl )
	sdl? ( >=media-libs/libsdl-1.2.5 )
	cdr? ( virtual/cdrtools )
	>=media-tv/mythtv-${PV}
	libvisual? ( =media-libs/libvisual-0.4* )"

pkg_config() {
	if use libvisual && ! use sdl; then
		eerror "libvisual support requires sdl support. enable 'sdl' USE flag"
		die "libvisual support requires sdl support. enable 'sdl' USE flag"
	fi
}

setup_pro() {
	return 0
}

src_compile() {
	myconf="${myconf}
		$(use_enable aac)
		$(use_enable X fftw)
		$(use_enable opengl)
		$(use_enable sdl)
		$(use_enable libvisual)"

	myth-svn_src_compile
}

