# Copyright (C) 2021-2023 by the FEM on Colab authors
#
# This file is part of FEM on Colab.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Download latest pip release
PIP_RELEASE_URL=$(curl -s https://pypi.org/pypi/pip/json | jq -r ".urls[0].url")
PIP_RELEASE_FILE=${PIP_RELEASE_URL##*/}
wget ${PIP_RELEASE_URL} -O ${PIP_RELEASE_FILE}
export PYTHONPATH=/usr/lib/python3.8/dist-packages:/usr/lib/python3.8/site-packages
PYTHONUSERBASE=/usr python3 ${PIP_RELEASE_FILE}/pip install --no-index --user ${PIP_RELEASE_FILE}
rm -f ${PIP_RELEASE_FILE}
