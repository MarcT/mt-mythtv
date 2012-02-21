# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit distutils

MY_PN="IMDbPY"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python package to access the IMDb movie database"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://imdbpy.sourceforge.net/"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
LICENSE="GPL-2"
IUSE="doc"
DEPEND="virtual/python
	dev-python/setuptools"

S="${WORKDIR}"/${MY_P}

src_install() {
	distutils_src_install
	use doc && dodoc docs/*
}


