# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/mythtv-9999.ebuild,v 1.3 2009/07/10 14:05:04 Marc Tousignant Exp $

EAPI="2"
inherit myth-git qt4 flag-o-matic multilib eutils toolchain-funcs

DESCRIPTION="Homebrew PVR project"
HOMEPAGE="http://www.mythtv.org/"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE_VIDEO_CARDS="video_cards_i810 video_cards_nvidia video_cards_via"

IUSE="alsa altivec autostart dbox2 debug directfb directv dvb dvd fftw
hdhomerun hdpvr ieee1394 iptv ivtv jack joystick latm lcd lirc mmx opengl 
oss perl profile proc-opt python tiff vdpau vorbis X xv xvmc ${IUSE_VIDEO_CARDS}"

RDEPEND="media-fonts/dejavu
	media-fonts/corefonts
	>=media-libs/freetype-2.0
	>=media-sound/lame-3.93.1
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXv
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	>=x11-libs/qt-core-4.4:4[qt3support]
	>=x11-libs/qt-gui-4.4:4[qt3support,tiff?]
	>=x11-libs/qt-sql-4.4:4[qt3support,mysql]
	>=x11-libs/qt-opengl-4.4:4[qt3support]
	>=x11-libs/qt-webkit-4.4:4
	virtual/mysql
	virtual/opengl
	virtual/glu
	|| ( >=net-misc/wget-1.9.1 >=media-tv/xmltv-0.5.43 )
	alsa? ( >=media-libs/alsa-lib-0.9 )
	autostart? ( 	net-dialup/mingetty
			x11-wm/evilwm
			x11-apps/xset )
	directv? ( virtual/perl-Time-HiRes )
	dvb? ( media-libs/libdvb media-tv/linuxtv-dvb-headers )
	dvd? ( media-libs/libdvdcss )
	fftw? ( sci-libs/fftw:3.0 )
	ieee1394? ( 	>=sys-libs/libraw1394-1.2.0
			>=sys-libs/libavc1394-0.5.0
			>=media-libs/libiec61883-1.0.0 )
	ivtv? ( media-tv/ivtv-utils )
	jack? ( media-sound/jack-audio-connection-kit )
	latm? ( media-libs/faad2 )
	lcd? ( app-misc/lcdproc )
	lirc? ( app-misc/lirc )
	perl? ( dev-perl/DBD-mysql )
	python? ( dev-python/mysql-python )
	vdpau? ( >=x11-drivers/nvidia-drivers-180.40 )
	xvmc? ( 	x11-libs/libXvMC
			video_cards_nvidia? ( x11-drivers/nvidia-drivers )
			video_cards_via? ( x11-drivers/xf86-video-via )
			video_cards_i810? ( x11-drivers/xf86-video-i810 ) )"

DEPEND="${RDEPEND}
	x11-proto/xineramaproto
	x11-proto/xf86vidmodeproto
	x11-apps/xinit"

PDEPEND=""

pkg_setup() {
	if use xvmc && use video_cards_nvidia; then
		elog
		elog "For NVIDIA based cards, the XvMC renderer only works on"
		elog "the NVIDIA 4, 5, 6 & 7 series cards."
	fi

	if use vdpau; then
		elog
		elog "The VDPAU renderer only works on"
		elog "the NVIDIA 8 series and higher cards."
		if ! use video_cards_nvidia; then
			die "You enabled VDPAU without NVIDIA"
		fi
	fi

	if use xvmc && [[ ! -s "${ROOT}/etc/X11/XvMCConfig" ]]; then
		ewarn
		ewarn "No XvMC implementation has been selected yet"
		ewarn "Use 'eselect xvmc list' for a list of available choices"
		ewarn "Then use 'eselect xvmc set <choice>' to choose"
		ewarn "'eselect xvmc set nvidia' for example"
	fi

	if use autostart; then
		elog
		elog "Please add the following to your /etc/inittab file at the end of"
		elog "the TERMINALS section"
		elog "c8:2345:respawn:/sbin/mingetty --autologin mythtv tty8"
	fi

}

src_unpack() {
	myth-git_src_unpack || die "unpack failed"

	cd ${S}/mythtv

	epatch "${FILESDIR}"/gentoo-myth-config-fix.diff
	epatch "${FILESDIR}"/${PN}-0.22-sandbox.patch

}

setup_pro() {
#	cp -fR /usr/portage/distfiles/svn-src/mythtv/mythtv/.svn ${S}

        # upstream wants the revision number in their version.cpp
        # since the subversion.eclass strips out the .svn directory
        # svnversion in MythTV's build doesn't work
#        sed -e "s:\`(svnversion \$\${SVNTREEDIR} 2>\/dev\/null) || echo Unknown\`:${MYTHTV_SVN_REVISION}:" \
#                -i "${S}"/version.pro || die "svnversion sed failed"

        # Perl bits need to go into vender_perl and not site_perl
        sed -e "s:pure_install:pure_install INSTALLDIRS=vendor:" \
                -i "${S}"/mythtv/bindings/perl/Makefile
}

src_configure() {
	use debug && use profile && die "You can not have USE="debug" and USE="profile" at the same time. Must disable one or the other."

	myconf="$(use_enable alsa audio-alsa)
		$(use_enable altivec)
		$(use_enable directfb)
		$(use_enable dvb)
		$(use_enable hdhomerun)
		$(use_enable hdpvr)
		$(use_enable ieee1394 firewire)
		$(use_enable iptv)
		$(use_enable ivtv)
		$(use_enable jack audio-jack)
		$(use_enable joystick joystick-menu)
		$(use_enable lirc)
		$(use_enable opengl opengl-vsync)
		$(use_enable opengl opengl-video)
		$(use_enable oss audio-oss)
		$(use_enable proc-opt)
		$(use_enable vdpau)
		$(use_enable X x11)
		$(use_enable xv)
		$(use_enable xvmc)"

	use debug && myconf="${myconf} --compile-type=debug"
	use profile && myconf="${myconf} --compile-type=profile"
}

src_compile() {
	myth-git_src_compile
}

src_install() {
	myth-git_src_install || die "install failed"

	insinto /usr/share/mythtv/database
	doins database/*

	exeinto /usr/share/mythtv
	doexe "${FILESDIR}/mythfilldatabase.cron"

	exeinto /etc/init.d
	newexe "${FILESDIR}/mythbackend.rc6" mythbackend
	insinto /etc/conf.d
	newins "${FILESDIR}/mythbackend.conf" mythbackend

	dodoc keys.txt docs/*.{txt,pdf}
	dohtml docs/*.html

	keepdir /var/{log,run}/mythtv
}
