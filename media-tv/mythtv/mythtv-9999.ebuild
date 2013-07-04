# Copyright 1999-2009 Gentoo Foundation
# Copyright 2009-2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/mythtv-9999.ebuild,v 1.3 2009/07/10 14:05:04 Marc Tousignant Exp $

EAPI="5"
MYTHTV_BRANCH="fixes/0.26"
inherit myth-git qt4-r2 flag-o-matic multilib eutils toolchain-funcs python
inherit linux-info

DESCRIPTION="Homebrew PVR project"
HOMEPAGE="http://www.mythtv.org/"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE_VIDEO_CARDS="video_cards_i810 video_cards_nvidia video_cards_via"

IUSE="alsa altivec ass autostart bluray cec ceton crystalhd dbox2 debug directv dvb dvd
fftw hdhomerun hdpvr hls ieee1394 iptv ivtv jack joystick latm lcd lirc mmx opengl
oss perl profile proc-opt pulseaudio python raop tiff vaapi vdpau vorbis xmltv xv xvid
${IUSE_VIDEO_CARDS}"

SDEPEND="
	>=media-sound/lame-3.93.1
	virtual/glu
	virtual/mysql
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXinerama
	x11-libs/libXv
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	dev-qt/qtcore:4[qt3support]
	dev-qt/qtgui:4[qt3support]
	dev-qt/qtsql:4[qt3support,mysql]
	dev-qt/qtopengl:4[qt3support]
	dev-qt/qtwebkit:4
	alsa? ( >=media-libs/alsa-lib-0.9 )
	ass? ( media-libs/libass )
	bluray? (	dev-libs/libxml2
			media-libs/libbluray )
	directv? ( virtual/perl-Time-HiRes )
	cec? (	dev-libs/libcec )
	dvb? (	media-libs/libdvb
		virtual/linuxtv-dvb-headers )
	fftw? ( sci-libs/fftw )
	hls? (	>=media-libs/x264-0.0.20100605
		media-libs/libvpx
		media-sound/lame 
		media-libs/faac )
	ieee1394? (	>=sys-libs/libraw1394-1.2.0
			>=sys-libs/libavc1394-0.5.3
			>=media-libs/libiec61883-1.0.0 )
	ivtv? ( media-tv/ivtv-utils )
	jack? ( media-sound/jack-audio-connection-kit )
	latm? ( media-libs/faad2 )
	lcd? ( app-misc/lcdproc )
	lirc? ( app-misc/lirc )
	perl? (	dev-perl/DBD-mysql
		dev-perl/Net-UPnP
		dev-perl/LWP-Protocol-https
		dev-perl/HTTP-Message
		dev-perl/IO-Socket-INET6
		>=dev-perl/libwww-perl-5 )
	pulseaudio? ( media-sound/pulseaudio )
	python? (	dev-python/mysql-python
			dev-python/lxml
			dev-python/urlgrabber )
	raop? (	net-dns/avahi[mdnsresponder-compat] )
	vaapi? ( x11-libs/libva )
	vdpau? ( x11-libs/libvdpau )
	xvid? ( >=media-libs/xvid-1.1.0 )
	!media-tv/mythtv-bindings
	!media-plugins/mythvideo
	!x11-themes/mythtv-themes"

RDEPEND="${SDEPEND}
	media-fonts/corefonts
	media-fonts/dejavu
	media-fonts/liberation-fonts
	>=media-libs/freetype-2.0
	x11-apps/xinit
	autostart? (	net-dialup/mingetty
			x11-wm/evilwm
			x11-apps/xset )
	dvd? ( media-libs/libdvdcss )
	video_cards_nvidia? (	x11-drivers/nvidia-drivers 
				vdpau? ( >=x11-drivers/nvidia-drivers-256 ) )
	xmltv? ( >=media-tv/xmltv-0.5.43 )"

DEPEND="${SDEPEND}
	x11-proto/xineramaproto
	x11-proto/xf86vidmodeproto
	x11-apps/xinit
	dev-lang/yasm"

pkg_setup() {
	if use vdpau; then
		elog
		elog "The VDPAU renderer only works on"
		elog "the NVIDIA 8 series and higher cards."
		if ! use video_cards_nvidia; then
			die "You enabled VDPAU without NVIDIA"
		fi
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

	epatch "${FILESDIR}"/${PN}-0.22-sandbox.patch

}

setup_pro() {
        # upstream wants the revision number in their version.cpp
        # since the subversion.eclass strips out the .svn directory
        # svnversion in MythTV's build doesn't work

        cd "${S}"
        MYTHTV_VERSION=$(git describe)
        sed -e "s#\${SOURCE_VERSION}#${MYTHTV_VERSION}#g" \
                -e "s#\${BRANCH}#${MYTHTV_BRANCH}#g" \
                -i "${S}"/mythtv/version.sh

        # Perl bits need to go into vender_perl and not site_perl
        sed -e "s:pure_install:pure_install INSTALLDIRS=vendor:" \
                -i "${S}"/mythtv/bindings/perl/Makefile
}

src_configure() {
	use debug && use profile && die "You can not have USE="debug" and USE="profile" at the same time. Must disable one or the other."

	myconf="--enable-pic
		$(use_enable alsa audio-alsa)
		$(use_enable altivec)
		$(use_enable jack audio-jack)
		$(use_enable pulseaudio audio-pulseoutput)
		$(use_enable dvb)
		$(use_enable ieee1394 firewire)
		$(use_enable lirc)
		--dvb-path=/usr/include
		--enable-xrandr
		$(use_enable xv)
		--enable-x11"

	if use perl && use python
	then
		myconf="${myconf} --with-bindings=perl,python"
	elif use perl
	then
		myconf="${myconf} --without-bindings=python"
		myconf="${myconf} --with-bindings=perl"
	elif use python
	then
		myconf="${myconf} --without-bindings=perl"
		myconf="${myconf} --with-bindings=python"
		myconf="${myconf} --python=$(PYTHON)"
	else
		myconf="${myconf} --without-bindings=perl,python"
	fi

	use debug && myconf="${myconf} --compile-type=debug"

	use profile && myconf="${myconf} --compile-type=profile
		--enable-proc-opt"

	myconf="${myconf}
		$(use_enable vdpau)
		$(use_enable vaapi)
		$(use_enable crystalhd)
		$(use_enable xvid libxvid)"

	use hls && myconf="${myconf}
		--enable-libmp3lame
		--enable-libx264
		--enable-libvpx
		--enable-libfaac
		--enable-nonfree"

	myconf="${myconf}
		$(use_enable joystick joystick-menu)
		$(use_enable cec libcec)
		--enable-symbol-visibility
		$(use_enable opengl opengl-video)
		$(use_enable oss audio-oss)
		$(use_enable ceton)
		$(use_enable hdhomerun)
		$(use_enable hdpvr)
		$(use_enable iptv)
		$(use_enable ivtv)"

	has distcc ${FEATURES} || myconf="${myconf} --disable-distcc"
	has ccache ${FEATURES} || myconf="${myconf} --disable-ccache"
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
