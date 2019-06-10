# Copyright 2019 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit git-r3

DESCRIPTION="Fake Android Container Pi"

EGIT_REPO_URI="https://github.com/somulimo/android-container-pi.git"
EGIT_BRANCH="master"
EGIT_COMMIT="94c6128547811d1b21d330d5534ef1526ba21f26"

LICENSE="no-source-code"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="
    chromeos-base/arc-base
    chromeos-base/arc-adbd
    chromeos-base/arc-apk-cache
    chromeos-base/arc-appfuse
    chromeos-base/arc-media-profiles-default
    chromeos-base/arc-myfiles
    chromeos-base/arc-obb-mounter
    chromeos-base/arc-removable-media
    chromeos-base/arc-sdcard
    chromeos-base/arc-setup
    dev-util/android-tools
    sys-devel/arc-build
"
RDEPEND="${DEPEND}"

RESTRICT="strip binchecks"

src_prepare() {
    cat system/system.raw.img.part* > system.raw.img
    cat vendor/vendor.raw.img.part* > vendor.raw.img
}

src_install() {
    insinto /opt/google/containers/android
    doins system.raw.img
    doins vendor.raw.img
}
