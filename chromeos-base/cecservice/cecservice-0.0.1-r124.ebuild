# Copyright 2018 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=5
CROS_WORKON_COMMIT="8bccc9f928eb67030ec5de23a7ad5c8f9ca24bbe"
CROS_WORKON_TREE=("f354d140e04d861ac5457214dd14961f6c512112" "87036346fd6ba7bb92b67f40ded3277833a88092" "dc1506ef7c8cfd2c5ffd1809dac05596ec18773c")
CROS_WORKON_LOCALNAME="platform2"
CROS_WORKON_PROJECT="chromiumos/platform2"
CROS_WORKON_INCREMENTAL_BUILD=1
CROS_WORKON_OUTOFTREE_BUILD=1
CROS_WORKON_SUBTREE="common-mk cecservice .gn"

PLATFORM_SUBDIR="cecservice"

inherit cros-workon platform udev user

DESCRIPTION="Chrome OS CEC service"
HOMEPAGE="https://chromium.googlesource.com/chromiumos/platform2/+/master/cecservice"
LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	chromeos-base/libbrillo
"
DEPEND="
	chromeos-base/system_api
	${RDEPEND}
"

pkg_preinst() {
	enewuser "cecservice"
	enewgroup "cecservice"
}

platform_pkg_test() {
	platform_test "run" "${OUT}/cecservice_testrunner"
}

src_install() {
	dosbin "${OUT}"/cecservice

	udev_dorules share/99-cec.rules

	# Install DBus config.
	insinto /etc/dbus-1/system.d
	doins share/org.chromium.CecService.conf

	# Install upstart script.
	insinto /etc/init
	doins share/cecservice.conf
}
