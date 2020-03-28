# Copyright 2017 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=5

CROS_WORKON_COMMIT="2707655b88df0cb7b8ea95fcd50101c1008f8fd2"
CROS_WORKON_TREE=("e7dba8c91c1f3257c34d4a7ffff0ea2537aeb6bb" "d58be6324ba2a1d0452d23bafb39c869c5ed2cd6" "4d7dc42c9bedef921a1f4a11dcfc899982d50674" "9863ee9778012b49f27d5c4a939f6b7e6c1cf36e" "2ef18d1c42c7aee2c4bb4110359103045c055adf")
CROS_WORKON_PROJECT="chromiumos/platform2"
CROS_WORKON_LOCALNAME="../platform2"
CROS_WORKON_SUBTREE=".gn camera/build camera/common camera/include common-mk"
CROS_WORKON_OUTOFTREE_BUILD="1"
CROS_WORKON_INCREMENTAL_BUILD="1"

PLATFORM_SUBDIR="camera/common/libcamera_common"
CROS_CAMERA_TESTS=(
	"future_test"
)

inherit cros-camera cros-workon platform

DESCRIPTION="Chrome OS HAL common util."

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"

RDEPEND="
	!media-libs/arc-camera3-libcamera_common
	virtual/libudev"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	dolib.so "${OUT}/lib/libcamera_common.so"

	cros-camera_doheader ../../include/cros-camera/common.h \
		../../include/cros-camera/constants.h \
		../../include/cros-camera/export.h \
		../../include/cros-camera/future.h \
		../../include/cros-camera/future_internal.h \
		../../include/cros-camera/camera_thread.h

	cros-camera_dopc ../libcamera_common.pc.template
}
