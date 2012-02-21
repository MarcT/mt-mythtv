# Copyright 1999-2009 Gentoo Foundation
# Copyright 2009 Marc Tousignant
#  ( If you make changes, please add a copyright notice above, but
#    never remove an existing notice. )
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
inherit perl-module

DESCRIPTION="Perl extension for rounding numbers"
SRC_URI="mirror://cpan/authors/id/G/GR/GROMMEL/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~grommel/Math-Round/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
