# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuvexport/nuvexport-0.5_p20080311.ebuild,v 1.2 2009/01/10 14:45:35 beandog Exp $

EAPI="2"
inherit eutils subversion

ESVN_REPO_URI="http://cvs.mythtv.org/svn/branches/release-0-22-fixes/mythextras/nuvexport"

DESCRIPTION="Export from mythtv recorded NuppelVideo files"
HOMEPAGE="http://www.forevermore.net/mythtv/"
LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=""
RDEPEND="dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/DateManip
	media-video/ffmpeg[encode,threads,xvid]
	media-video/mjpegtools
	media-video/transcode[mjpeg]
	media-libs/id3lib
	media-video/mplayer
	>=media-tv/mythtv-${PV}"

S="${WORKDIR}/nuvexport-0.5"

src_install() {
	einstall || die "einstall died"
}
