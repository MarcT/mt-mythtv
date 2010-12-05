# Copyright 1999-2009 Gentoo Foundation
# Copyright 2005 Preston Crow
# Modifications by (Simon at Koala) from mythtv-dev list.
# Modifications by Marc Tousignant 2009
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit myth-git

DESCRIPTION="Video player module for MythTV."
HOMEPAGE="http://www.mythtv.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug jamu"

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

src_configure() {
	return 0
}

src_install() {
	myth-git_src_install

	# setup JAMU cron jobs
	if use jamu; then
		exeinto /etc/cron.daily
		newexe "${FILESDIR}/mythvideo.daily" mythvideo || die
		exeinto /etc/cron.hourly
		newexe "${FILESDIR}/mythvideo.hourly" mythvideo || die
		exeinto /etc/cron.weekly
		newexe "${FILESDIR}/mythvideo.weekly" mythvideo || die
		insinto /home/mythtv/.mythtv/
		newins mythplugins/mythvideo/mythvideo/scripts/jamu-example.conf jamu.conf || die
	fi
}

pkg_postinst() {
	elog "MythVideo can use any media player to playback files if you"
	elog "are *NOT* using Storage Groups. If you are using Storage"
	elog "Groups, you *MUST* use the Internal player."
	elog
	elog "Otherwise, you can install mplayer, xine or any other video"
	elog "player and use that instead by configuring the player to use."
	elog "The default is 'Internal'."
}
