# Copyright 1999-2004 Gentoo Foundation
# Copyright 2005 Preston Crow
# Copyright 2009-2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/myth.eclass,v 1.4 2004/09/15 14:40:33 aliz Exp $
#
# Author: Daniel Ahlberg <aliz@gentoo.org>
# Modified: Preston Crow
# Modified: Marc Tousignant
#

inherit git-2 eutils flag-o-matic multilib versionator toolchain-funcs

ECLASS=myth-git
INHERITED="${INHERITED} ${ECLASS}"
IUSE="${IUSE} nls"

EXPORT_FUNCTIONS src_unpack src_compile src_install

EGIT_BRANCH="fixes/0.25"

MYTHPLUGINS="mytharchive mythbrowser mythgallery mythgame mythmusic mythnetvision mythnews mythweather mythzoneminder"

_MODULE=${PN}

if has ${_MODULE} ${MYTHPLUGINS} ; then
	EGIT_REPO_URI="git://github.com/MythTV/mythtv.git"
	EGIT_PROJECT=mythplugins
	EGIT_COMMIT="${MYTHTV_GIT_REVISION}"
elif [ "${_MODULE}" == "mythtv-themes" ]; then
	EGIT_REPO_URI="git://github.com/MythTV/myththemes.git"
	EGIT_PROJECT=myththemes
	EGIT_COMMIT="${MYTHTHEMES_GIT_REVISION}"
elif [ "${_MODULE}" == "mythweb" ]; then
	EGIT_REPO_URI="git://github.com/MythTV/mythweb.git"
	EGIT_PROJECT=mythweb
	EGIT_COMMIT="${MYTHWEB_GIT_REVISION}"
else
	EGIT_REPO_URI="git://github.com/MythTV/mythtv.git"
	EGIT_PROJECT=${_MODULE/frontend/tv}
	EGIT_COMMIT="${MYTHTV_GIT_REVISION}"
fi

if [ "${EGIT_COMMIT}" == "" ]; then
        EGIT_COMMIT="${EGIT_BRANCH}"
fi

S="${WORKDIR}"

myth-git_src_unpack() {

	pkg_pro=${_MODULE}.pro
	if has ${_MODULE} ${MYTHPLUGINS} ; then
		pkg_pro="mythplugins.pro"
	elif [ "${_MODULE}" == "mythfrontend" ]; then
		pkg_pro="mythtv.pro"
	elif [ "${_MODULE}" == "mythtv-themes" ]; then
		pkg_pro="myththemes.pro"
	elif [ "${_MODULE}" == "mythtv-themes-old" ]; then
		pkg_pro="myththemes.pro"
	elif [ "${_MODULE}" == "mythtv-themes-extra" ]; then
		pkg_pro="myththemes.pro"
	fi

	git-2_src_unpack

	if has ${_MODULE} ${MYTHPLUGINS} ; then
		cd ${S}/mythplugins
	elif [ "${_MODULE}" == "mythtv-themes" ]; then
		cd ${S}
	else
		cd ${S}/${_MODULE}
	fi

	if use debug ; then
		FEATURES="${FEATURES} nostrip"
		sed \
			-e '/profile:CONFIG +=/s/release/debug/' \
			-i 'settings.pro' || die "Setting debug failed"
	fi

	if ! use nls ; then
		if has ${_MODULE} ${MYTHPLUGINS} ; then
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

myth-git_src_compile() {
	if has ${_MODULE} ${MYTHPLUGINS} ; then
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

	if has ${_MODULE} ${MYTHPLUGINS} ; then
		cd ${S}/mythplugins
	elif [ "${_MODULE}" == "mythtv-themes" ]; then
		cd ${S}
	else
		cd ${S}/${_MODULE}
	fi

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


	if has ${_MODULE} ${MYTHPLUGINS} ; then
		for X in */ */*/ ; do cd $X ; ln -s ../mythconfig.mak . ; cd ${S}/mythplugins ; done
	elif [ "${_MODULE}" == "mythtv-themes" ]; then
		for X in */ */*/ ; do cd $X ; ln -s ../mythconfig.mak . ; cd ${S}/ ; done
	else
		for X in */ */*/ ; do cd $X ; ln -s ../mythconfig.mak . ; cd ${S}/${_MODULE} ; done
	fi
	qmake ${pkg_pro}
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" "${@}" || die
}

myth-git_src_install() {
	if has ${_MODULE} ${MYTHPLUGINS} ; then
		cd ${S}/mythplugins
	elif [ "${_MODULE}" == "mythtv-themes" ]; then
		cd ${S}
	else
		cd ${S}/${_MODULE}
	fi

	einstall INSTALL_ROOT="${D}"
	for doc in AUTHORS COPYING FAQ UPGRADING ChangeLog README; do
		test -e "${doc}" && dodoc ${doc}
	done
}
