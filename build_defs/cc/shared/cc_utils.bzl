# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
    "http_file",
)
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

GVISOR_VERSION = "20241104.0"

def cc_utils():
    maybe(
        http_archive,
        name = "nlohmann_json",
        build_file = Label("//build_defs/cc/shared/build_targets:nlohmann.BUILD"),
        sha256 = "e5c7a9f49a16814be27e4ed0ee900ecd0092bfb7dbfca65b5a421b774dccaaed",
        urls = [
            "https://github.com/nlohmann/json/releases/download/v3.11.2/include.zip",
        ],
    )

    maybe(
        http_archive,
        name = "oneTBB",
        # Release 2021.10.0 dated 2023-07-24
        sha256 = "78fb7bb29b415f53de21a68c4fdf97de8ae035090d9ee9caa221e32c6e79567c",
        strip_prefix = "oneTBB-2021.10.0",
        urls = ["https://github.com/oneapi-src/oneTBB/archive/refs/tags/v2021.10.0.zip"],
    )

    maybe(
        http_archive,
        name = "rules_fuzzing",
        sha256 = "e6bc219bfac9e1f83b327dd090f728a9f973ee99b9b5d8e5a184a2732ef08623",
        strip_prefix = "rules_fuzzing-0.5.2",
        urls = ["https://github.com/bazelbuild/rules_fuzzing/archive/v0.5.2.zip"],
    )

    maybe(
        http_archive,
        name = "com_google_tcmalloc",
        sha256 = "d4bef5f15eb54cf481d6da96ffa6616a090009e94b336385445ee09427d8e512",
        strip_prefix = "tcmalloc-cda5074afb75ab02cf4d621986308ab7421dbbf8",
        urls = ["https://github.com/google/tcmalloc/archive/cda5074afb75ab02cf4d621986308ab7421dbbf8.zip"],
    )

    _gvisor_utils()

def _gvisor_utils(version = GVISOR_VERSION):
    release_url = "https://storage.googleapis.com/gvisor/releases/release/{}".format(version)
    maybe(
        http_file,
        name = "gvisor_runsc_amd64",
        downloaded_file_path = "runsc",
        executable = True,
        sha256 = "6c4ca2b1a0d207e4a9fa53213f2a9a7f664cb3405458fb64550dc50a62662537",
        urls = ["{}/x86_64/runsc".format(release_url)],
    )

    maybe(
        http_file,
        name = "gvisor_runsc_arm64",
        downloaded_file_path = "runsc",
        executable = True,
        sha256 = "e40d74987a65fa2369ab58060c3caac2759238922da1d6a9b4f4accfef9ec93f",
        urls = ["{}/aarch64/runsc".format(release_url)],
    )

    maybe(
        http_archive,
        name = "libcap",
        build_file = Label("//build_defs/cc/shared/build_targets:libcap.BUILD"),
        sha256 = "18f00ea97c7541af86379dec9d4d8ea838aac4a1f70177d81d91657e4e43b808",
        strip_prefix = "libcap-2.70",
        urls = [
            "https://git.kernel.org/pub/scm/libs/libcap/libcap.git/snapshot/libcap-2.70.tar.gz",
        ],
    )
