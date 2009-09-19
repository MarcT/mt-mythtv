# Copyright 1999-2004 Gentoo Foundation
# Copyright 2005 Preston Crow
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/myth.eclass,v 1.4 2004/09/15 14:40:33 aliz Exp $
#
# Author: Daniel Ahlberg <aliz@gentoo.org>
# Modified: Preston Crow
#

inherit subversion eutils flag-o-matic multilib versionator toolchain-funcs

ECLASS=myth-svn
INHERITED="${INHERITED} ${ECLASS}"
IUSE="${IUSE} nls debug"

ESVN_FETCH_CMD="svn co"
ESVN_UPDATE_CMD="svn up"

[ -z "${MYTHTV_SVN_REVISION}" ] || ESVN_FETCH_CMD="svn checkout --revision ${MYTHTV_SVN_REVISION}"
[ -z "${MYTHTV_SVN_REVISION}" ] || ESVN_UPDATE_CMD="svn update --revision ${MYTHTV_SVN_REVISION}"

EXPORT_FUNCTIONS src_unpack src_compile src_install

MYTHPLUGINS="mytharchive mythbrowser mythflix mythgallery mythgame mythmovies mythmusic mythnews mythvideo mythweather mythweb mythzoneminder"

_MODULE=${PN}

if hasq ${_MODULE} ${MYTHPLUGINS} ; then
	ESVN_REPO_URI="http://cvs.mythtv.org/svn/trunk/mythplugins"
	ESVN_PROJECT=mythplugins
elif [ "${_MODULE}" == "mythtv-themes" ]; then
	ESVN_REPO_URI="http://cvs.mythtv.org/svn/trunk/oldthemes"
	ESVN_PROJECT=oldthemes
elif [ "${_MODULE}" == "mythtv-themes-extra" ]; then
        ESVN_REPO_URI="http://cvs.mythtv.org/svn/trunk/themes"
        ESVN_PROJECT=themes
else
	ESVN_REPO_URI="http://cvs.mythtv.org/svn/trunk/mythtv"
	ESVN_PROJECT=${_MODULE/frontend/tv}
fi

#ESVN_STORE_DIR="${DISTDIR}/svn-src"

S="${WORKDIR}/${_MODULE}"

myth-svn_src_unpack() {
	#
	# Deal with subversion eclass avoiding updates when
	# the last run was within an hour
	#
	if hasq ${_MODULE} ${MYTHPLUGINS} ; then

		[ -z "${MYTHPLUGINS_SVN_REVISION}" ] || ESVN_FETCH_CMD="svn checkout --revision ${MYTHTV_SVN_REVISION}"
		[ -z "${MYTHPLUGINS_SVN_REVISION}" ] || ESVN_UPDATE_CMD="svn update --revision ${MYTHTV_SVN_REVISION}"

		ENTRIES=/usr/portage/distfiles/svn-src/mythplugins/mythplugins/.svn/entries
		if [ -f "${ENTRIES}" ] ; then
			local REV=$(grep '  revision="' ${ENTRIES} | sed -e 'sX^[^"]*XX' -e 'sX".*XX' )
			if [ -n "${MYTHPLUGINS_SVN_REVISION}" ] && [ "${REV}" != "${MYTHPLUGINS_SVN_REVISION}" ] ; then
				touch -t 199901010101 ${ENTRIES}
			fi
			local NOW=$(date +%s) UPDATE=$(date -r ${ENTRIES} +%s) INTERVAL=3600
			if (( ${NOW} - ${UPDATE} <= ${INTERVAL} )); then
				echo
				ewarn "You ran this within 1 hour of another myth plugin ebuild,"
		        	ewarn "so it will skip the update.  To bypass this:"
				ewarn " touch -t 199901010101 ${ENTRIES}"
				echo
			fi
		fi
	fi

	pkg_pro=${_MODULE}.pro
	if hasq ${_MODULE} ${MYTHPLUGINS} ; then
		pkg_pro="mythplugins.pro"
	elif [ "${_MODULE}" == "mythfrontend" ]; then
		pkg_pro="mythtv.pro"
	elif [ "${_MODULE}" == "mythtv-themes" ]; then
		pkg_pro="myththemes.pro"
	fi

	subversion_src_unpack ; cd ${S}

	if [[ ${_MODULE} == "mythmusic" ]] ; then
		epatch "${FILESDIR}"/6975-New_Audio_Setup.patch
	fi

	if use debug ; then
		FEATURES="${FEATURES} nostrip"
		sed \
			-e '/profile:CONFIG +=/s/release/debug/' \
			-i 'settings.pro' || die "Setting debug failed"
	fi

	if ! use nls ; then
		if hasq ${_MODULE} ${MYTHPLUGINS} ; then
			sed \
				-e "/^SUBDIRS/s:i18n::" \
				-i  ${_MODULE}/${_MODULE}.pro || die "Disable i18n failed"
		else
		sed \
			-e "/^SUBDIRS/s:i18n::" \
			-i ${pkg_pro} || die "Disable i18n failed (${pkg_pro})"
		fi
	fi

	setup_pro
}

myth-svn_src_compile() {
	if hasq ${_MODULE} ${MYTHPLUGINS} ; then
		for x in ${MYTHPLUGINS} ; do
			if [[ ${_MODULE} == ${x} ]] ; then
				myconf="${myconf} --enable-${x}"
			else
				myconf="${myconf} --disable-${x}"
			fi
		done
	fi
	# Myth doesn't use autoconf, and it rejects unexpected options.
	myconf=$(echo ${myconf} | sed -e 'sX--enable-audio-jackXXg' -e 'sX--enable-audio-alsaXXg' -e 'sX--enable-audio-artsXXg' -e 'sX--enable-audio-ossXXg' )
	sed -e 's/rm mythconfig.mak/rm -f mythconfig.mak/' -i configure

        ## CFLAG cleaning so it compiles
        MARCH=$(get-flag "march")
        MTUNE=$(get-flag "mtune")
        strip-flags
        filter-flags "-march=*" "-mtune=*" "-mcpu=*"
        filter-flags "-O" "-O?"

        if [[ -n "${MARCH}" ]]; then
                myconf="${myconf} --cpu=${MARCH}"
        fi
        if [[ -n "${MTUNE}" ]]; then
                myconf="${myconf} --tune=${MTUNE}"
        fi

#       myconf="${myconf} --extra-cxxflags=\"${CXXFLAGS}\" --extra-cflags=\"${CFLAGS}\""
#       hasq distcc ${FEATURES} || myconf="${myconf} --disable-distcc"
#       hasq ccache ${FEATURES} || myconf="${myconf} --disable-ccache"

        # let MythTV come up with our CFLAGS. Upstream will support this
        CFLAGS=""
        CXXFLAGS=""

        einfo "Running ./configure --prefix=/usr --mandir=/usr/share/man ${myconf}"
	./configure --prefix=/usr --mandir=/usr/share/man ${myconf}

	for X in */ */*/ ; do cd $X ; ln -s ../mythconfig.mak . ; cd ${S} ; done
	qmake ${pkg_pro}
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" "${@}" || die
}

myth-svn_src_install() {
	if hasq ${_MODULE} ${MYTHPLUGINS} ; then
		cd ${S}/${_MODULE}
	fi

	einstall INSTALL_ROOT="${D}"
	for doc in AUTHORS COPYING FAQ UPGRADING ChangeLog README; do
		test -e "${doc}" && dodoc ${doc}
	done
}
