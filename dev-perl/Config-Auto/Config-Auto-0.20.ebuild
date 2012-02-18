# Copyright 1999-2009 Gentoo Foundation
# Copyright 2010 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit perl-module

DESCRIPTION="Config::Auto - Magical config file parser"
SRC_URI="mirror://cpan/authors/id/K/KA/KANE/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kane/Config-Auto/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="amd64 x86 ~amd64 ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
