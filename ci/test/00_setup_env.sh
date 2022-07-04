#!/usr/bin/env bash
#
# Copyright (c) 2019 The Brocoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

export LC_ALL=C.UTF-8

echo "Setting specific values in env"
if [ -n "${FILE_ENV}" ]; then
  set -o errexit;
  # shellcheck disable=SC1090
  source "${FILE_ENV}"
fi

BASE_ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )"/../../ >/dev/null 2>&1 && pwd )
export BASE_ROOT_DIR

echo "Fallback to default values in env (if not yet set)"
# The number of parallel jobs to pass down to make and test_runner.py
export MAKEJOBS=${MAKEJOBS:--j4}
# A folder for the ci system to put temporary files (ccache, datadirs for tests, ...)
export BASE_SCRATCH_DIR=${BASE_SCRATCH_DIR:-$BASE_ROOT_DIR/ci/scratch/}
export HOST=${HOST:-x86_64-unknown-linux-gnu}
export RUN_UNIT_TESTS=${RUN_UNIT_TESTS:-true}
export RUN_FUNCTIONAL_TESTS=${RUN_FUNCTIONAL_TESTS:-true}
export RUN_FUZZ_TESTS=${RUN_FUZZ_TESTS:-false}
export DOCKER_NAME_TAG=${DOCKER_NAME_TAG:-ubuntu:18.04}
# Randomize test order.
# See https://www.boost.org/doc/libs/1_71_0/libs/test/doc/html/boost_test/utf_reference/rt_param_reference/random.html
export BOOST_TEST_RANDOM=${BOOST_TEST_RANDOM:-1}
export CCACHE_SIZE=${CCACHE_SIZE:-100M}
export CCACHE_TEMPDIR=${CCACHE_TEMPDIR:-/tmp/.ccache-temp}
export CCACHE_COMPRESS=${CCACHE_COMPRESS:-1}
export CCACHE_DIR=${CCACHE_DIR:-$BASE_SCRATCH_DIR/.ccache}
# Folder where the build is done (depends and dist). Can not be changed and is equal to the root of the git repo
export BASE_BUILD_DIR=${BASE_BUILD_DIR:-$BASE_ROOT_DIR}
# Folder where the build is done (bin and lib). Can not be changed.
export BASE_OUTDIR=${BASE_OUTDIR:-$BASE_BUILD_DIR/out/$HOST}
export SDK_URL=${SDK_URL:-https://brocoincore.org/depends-sources/sdks}
export WINEDEBUG=${WINEDEBUG:-fixme-all}
export DOCKER_PACKAGES=${DOCKER_PACKAGES:-build-essential libtool autotools-dev automake pkg-config bsdmainutils curl ca-certificates ccache python3}
export GOAL=${GOAL:-install}
export DIR_QA_ASSETS=${DIR_QA_ASSETS:-${BASE_BUILD_DIR}/qa-assets}
export PATH=${BASE_ROOT_DIR}/ci/retry:$PATH
export CI_RETRY_EXE=${CI_RETRY_EXE:retry}