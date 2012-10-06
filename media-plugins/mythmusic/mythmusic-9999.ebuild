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

DESCRIPTION="Music player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug cdr fftw opengl projectm"

RDEPEND="
	>=media-libs/libmad-0.15.1b
	>=media-libs/libvorbis-1.0
	>=media-libs/flac-1.1.2
	>=media-libs/taglib-1.4
	dev-libs/libcdio
	media-gfx/dcraw
	fftw? ( sci-libs/fftw )
	opengl? ( virtual/opengl )
	cdr? ( virtual/cdrtools )
	projectm? ( media-plugins/libvisual-projectm
				>=media-libs/libsdl-1.2.5 
				=media-libs/libvisual-0.4*
				)
	"

DEPEND="${RDEPEND}"

setup_pro() {
	return 0
}

src_configure() {
	myconf="${myconf}
		$(use_enable X fftw)
		$(use_enable opengl)"
}

src_compile() {
	myth-git_src_compile
}
