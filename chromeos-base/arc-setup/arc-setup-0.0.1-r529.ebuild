# Copyright 2017 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=5

CROS_WORKON_COMMIT="ff547a4418f6fd2659e4952e785f5a55f3396cb9"
CROS_WORKON_TREE=("f354d140e04d861ac5457214dd14961f6c512112" "b80db00ee0528d9571b243a4d17532405306ca1a" "8d6e5053d68a9fe6b3c1b206e5b0232b7943c660" "c1f42c15db13cb19dc9e96ca4f11231dcb21fde2" "dc1506ef7c8cfd2c5ffd1809dac05596ec18773c")
CROS_WORKON_INCREMENTAL_BUILD="1"
CROS_WORKON_LOCALNAME="platform2"
CROS_WORKON_PROJECT="chromiumos/platform2"
CROS_WORKON_OUTOFTREE_BUILD=1
# TODO(crbug.com/809389): Avoid directly including headers from other packages.
CROS_WORKON_SUBTREE="common-mk arc/setup chromeos-config metrics .gn"

PLATFORM_NATIVE_TEST="yes"
PLATFORM_SUBDIR="arc/setup"
PLATFORM_GYP_FILE="arc-setup.gyp"

inherit cros-workon platform

DESCRIPTION="Set up environment to run ARC."
HOMEPAGE="https://chromium.googlesource.com/chromiumos/platform2/+/master/arc/setup"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE="
	arcvm
	esdfs
	houdini
	houdini64
	ndk_translation
	unibuild"

RDEPEND="
	chromeos-base/bootstat
	!<chromeos-base/chromeos-cheets-scripts-0.0.4
	unibuild? ( chromeos-base/chromeos-config )
	chromeos-base/chromeos-config-tools
	chromeos-base/cryptohome-client
	chromeos-base/libbrillo
	chromeos-base/metrics
	chromeos-base/minijail
	chromeos-base/swap-init
	sys-libs/libselinux
	dev-libs/dbus-glib
	dev-libs/protobuf
	esdfs? ( sys-apps/restorecon )"

DEPEND="${RDEPEND}
	chromeos-base/system_api"


enable_esdfs() {
	[[ -f "$1" ]] || die
	local data=$(jq ".USE_ESDFS=true" "$1")
	echo "${data}" > "$1" || die
}


src_install() {
	dosbin "${OUT}"/arc-setup

	insinto /etc/init
	if ! use arcvm; then
		doins etc/arc-boot-continue.conf
		doins etc/arc-kmsg-logger.conf
		doins etc/arc-lifetime.conf
		doins etc/arc-sensor.conf
		doins etc/arc-update-restorecon-last.conf
	fi
	if use esdfs; then
		doins etc/arc-sdcard.conf
		doins etc/arc-sdcard-mount.conf
	fi
	doins etc/arc-sysctl.conf
	doins etc/arc-system-mount.conf
	doins etc/arc-ureadahead.conf
	doins etc/arc-ureadahead-trace.conf

	insinto /etc/dbus-1/system.d
	doins etc/dbus-1/ArcUpstart.conf

	insinto /usr/share/arc-setup
	doins etc/config.json

	if use esdfs; then
		enable_esdfs "${D}/usr/share/arc-setup/config.json"
	fi

	if ! use arcvm; then
		insinto /opt/google/containers/arc-art
		doins "${OUT}/dev-rootfs.squashfs"

		# container-root is where the root filesystem of the container in which
		# patchoat and dex2oat runs is mounted. dev-rootfs is mount point
		# for squashfs.
		diropts --mode=0700 --owner=root --group=root
		keepdir /opt/google/containers/arc-art/mountpoints/container-root
		keepdir /opt/google/containers/arc-art/mountpoints/dev-rootfs
		keepdir /opt/google/containers/arc-art/mountpoints/vendor
	fi
}

platform_pkg_test() {
	platform_test "run" "${OUT}/arc-setup_testrunner"
}
