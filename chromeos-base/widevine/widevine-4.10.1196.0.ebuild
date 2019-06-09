# Copyright 2019 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit git-r3

DESCRIPTION="Widevine Content Decryption Module"
HOMEPAGE="https://www.widevine.com/"

EGIT_REPO_URI="https://github.com/somulimo/widevine-cdm.git"
EGIT_BRANCH="master"
EGIT_COMMIT="d1749c42bbac609158c31a7a8991b91ed1634be2"

# Periodically check https://dl.google.com/widevine-cdm/current.txt

LICENSE="no-source-code"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
    chromeos-base/chromeos-chrome
"
DEPEND="${RDEPEND}"

src_install() {
    exeinto /opt/google/chrome
    doexe libwidevinecdm.so
}
