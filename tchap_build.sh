#! /bin/bash

#
# Copyright (c) 2025 DINUM
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

version=${1}
local_option=${2:local-only}

if [ $# -ne 2 ]; then
    echo "Usage: ${0} <version> (upload|local-only)" >&2
    exit 2
fi

if [ "$local_option" == "local-only" ]; then
	echo "Build version $version local-only"
	cd ./Tools/Release/Sources
	swift run release --version $version --local-only
elif [ "$local_option" == "upload" ]; then
	echo "Build version $version with upload on Github"
	cd ./Tools/Release/Sources
	swift run release --version $version
else
	echo "Usage: ${0} <version> (upload|local-only)" >&2
    exit 2
fi