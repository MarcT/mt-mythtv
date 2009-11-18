# Copyright 1999-2009 Gentoo Foundation
# Copyright 2005 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit perl-module

DESCRIPTION="Perl extension for rounding numbers"
SRC_URI="mirror://cpan/authors/id/G/GR/GROMMEL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~grommel/Math-Round/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
