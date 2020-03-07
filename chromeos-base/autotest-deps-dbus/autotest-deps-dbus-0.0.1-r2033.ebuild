# Copyright 2018 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=5
CROS_WORKON_COMMIT="dd82810f0d71d6cfc7340dd5a18f1f9c4ac93dce"
CROS_WORKON_TREE="377c209fc3c7d7bf028ed0e136d87de10ee911ad"
CROS_WORKON_PROJECT="chromiumos/third_party/autotest"
CROS_WORKON_LOCALNAME="third_party/autotest/files"

inherit cros-workon autotest-deponly

DESCRIPTION="Autotest D-Bus deps"
HOMEPAGE="http://www.chromium.org/"
SRC_URI=""
LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"

# Autotest enabled by default.
IUSE="+autotest"

AUTOTEST_DEPS_LIST="dbus_protos"

# NOTE: For deps, we need to keep *.a
AUTOTEST_FILE_MASK="*.tar.bz2 *.tbz2 *.tgz *.tar.gz"

DEPEND="chromeos-base/system_api
	dev-libs/protobuf:=
"

# Calling this here, so tests using this dep don't have to call setup_dep().
src_prepare() {
	autotest-deponly_src_prepare
}
