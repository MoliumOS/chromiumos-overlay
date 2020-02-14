# Copyright 2018 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CROS_WORKON_COMMIT="6fd95c3b34d594e486aea4e5511067eaa79ee77c"
CROS_WORKON_TREE=("2ef18d1c42c7aee2c4bb4110359103045c055adf" "943dd81681faff461b0934e0d7100af41fbd0747" "e7dba8c91c1f3257c34d4a7ffff0ea2537aeb6bb")
CROS_WORKON_INCREMENTAL_BUILD="1"
CROS_WORKON_LOCALNAME="platform2"
CROS_WORKON_PROJECT="chromiumos/platform2"
CROS_WORKON_OUTOFTREE_BUILD=1
CROS_WORKON_SUBTREE="common-mk arc/apk-cache .gn"

PLATFORM_NATIVE_TEST="yes"
PLATFORM_SUBDIR="arc/apk-cache"

inherit cros-workon platform

DESCRIPTION="Maintains APK cache in ARC."
HOMEPAGE="https://chromium.googlesource.com/chromiumos/platform2/+/master/arc/apk-cache"

LICENSE="BSD-Google"
KEYWORDS="*"
IUSE="+seccomp"

RDEPEND="
	chromeos-base/minijail
"

src_install() {
	insinto /etc/init
	doins init/apk-cache-cleaner.conf

	# Install seccomp policy file.
	insinto /usr/share/policy
	use seccomp && newins \
		"seccomp/apk-cache-cleaner-seccomp-${ARCH}.policy" \
		apk-cache-cleaner-seccomp.policy

	dosbin "${OUT}/apk-cache-cleaner"
	dosbin apk-cache-cleaner-jailed
}

platform_pkg_test() {
	platform_test "run" "${OUT}/apk-cache-cleaner_testrunner"
}
