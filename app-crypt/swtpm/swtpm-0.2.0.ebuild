# Copyright 2019 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils git-r3

DESCRIPTION="Software TPM Emulator"
HOMEPAGE="https://github.com/stefanberger/swtpm"

EGIT_REPO_URI="https://github.com/stefanberger/swtpm.git"
# EGIT_BRANCH="stable-0.1.0"
EGIT_BRANCH="master"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
    dev-libs/libtpms
    dev-libs/openssl
    sys-libs/libseccomp
"
RDEPEND="${DEPEND}"

src_prepare() {
    eapply_user
    eautoreconf
}

src_configure() {
    econf --prefix=/usr --with-openssl --with-tpm2
}

src_install() {
    default
    insinto /etc/init
    doins "${FILESDIR}"/etc/init/swtpm.conf
}
