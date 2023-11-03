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

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

def container_deps():
    images = {
        "runtime-debian-debug-nonroot": {
            "arch_hashes": {
                # cc-debian11:debug-nonroot
                "amd64": "7caec0c1274f808d29492012a5c3f57331c7f44d5e9e83acf5819eb2e3ae14dc",
                "arm64": "f17be941beeaa468ef03fc986cd525fe61e7550affc12fbd4160ec9e1dac9c1d",
            },
            "registry": "gcr.io",
            "repository": "distroless/cc-debian11",
        },
        "runtime-debian-debug-root": {
            # debug build so we can use 'sh'. Root, for gcp coordinators
            # auth to work
            "arch_hashes": {
                "amd64": "6865ad48467c89c3c3524d4c426f52ad12d9ab7dec31fad31fae69da40eb6445",
                "arm64": "3c399c24b13bfef7e38257831b1bb05cbddbbc4d0327df87a21b6fbbb2480bc9",
            },
            "registry": "gcr.io",
            "repository": "distroless/cc-debian11",
        },
        # Non-distroless; only for debugging purposes
        "runtime-ubuntu-fulldist-debug-root": {
            # Ubuntu 20.04
            "arch_hashes": {
                "amd64": "218bb51abbd1864df8be26166f847547b3851a89999ca7bfceb85ca9b5d2e95d",
            },
            "registry": "docker.io",
            "repository": "library/ubuntu",
        },
    }

    [
        container_pull(
            name = img_name + "-" + arch,
            digest = "sha256:" + hash,
            registry = image["registry"],
            repository = image["repository"],
        )
        for img_name, image in images.items()
        for arch, hash in image["arch_hashes"].items()
    ]
