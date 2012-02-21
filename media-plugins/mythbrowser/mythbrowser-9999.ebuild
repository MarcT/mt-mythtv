# Copyright 1999-2010 Gentoo Foundation
# Copyright 2005 Preston Crow
# Copyright 2009-2010 Marc Tousignatn
# Modifications by (Simon at Koala) from mythtv-dev list.
# Modifications by Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit myth-git kde4-functions

DESCRIPTION="Web browser module for MythTV."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=sys-apps/sed-4
	x11-libs/qt-webkit
	>=media-tv/mythtv-${PV}"

setup_pro() {
	set-kdedir
	echo "INCLUDEPATH += ${KDEDIR}/include" >> ../settings.pro
	echo "EXTRA_LIBS += -L${KDEDIR}/lib" >> ../settings.pro
#	myconf="${myconf} kdeinclude=$(kde-config --prefix)/include"

	#
	# set up the correct location for KDE libraries and include files
	#
	sed \
		-e "s:INCLUDEPATH += /usr/kde/3.3/include:INCLUDEPATH += ${KDEDIR}/include:" \
		-e "s:LIBPATH += /usr/kde/3.3/lib:LIBPATH += ${KDEDIR}/lib:" \
		-i 'settings.pro' || die "Setting kde library and include file location in settings.pro failed"
	sed \
		-e "s:/opt/kde3/include:${KDEDIR}/include:" \
		-i 'configure' || die "Setting kde include file location in configure failed"

	return 0
}

src_configure() {
        return 0
}
