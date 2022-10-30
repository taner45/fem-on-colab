# Copyright (C) 2021-2022 by the FEM on Colab authors
#
# This file is part of FEM on Colab.
#
# SPDX-License-Identifier: MIT

set -e
set -x

# Check for existing installation
INSTALL_PREFIX=${INSTALL_PREFIX:-"INSTALL_PREFIX_IN"}
INSTALL_PREFIX_DEPTH=$(echo $INSTALL_PREFIX | awk -F"/" '{print NF-1}')
SHARE_PREFIX="$INSTALL_PREFIX/share/fem-on-colab"
SLEPC4PY_INSTALLED="$SHARE_PREFIX/slepc4py.installed"

if [[ ! -f $SLEPC4PY_INSTALLED ]]; then
    # Install petsc4py (and its dependencies)
    PETSC4PY_INSTALL_SCRIPT_PATH=${PETSC4PY_INSTALL_SCRIPT_PATH:-"PETSC4PY_INSTALL_SCRIPT_PATH_IN"}
    [[ $PETSC4PY_INSTALL_SCRIPT_PATH == http* ]] && PETSC4PY_INSTALL_SCRIPT_DOWNLOAD=${PETSC4PY_INSTALL_SCRIPT_PATH} && PETSC4PY_INSTALL_SCRIPT_PATH=/tmp/petsc4py-install.sh && [[ ! -f ${PETSC4PY_INSTALL_SCRIPT_PATH} ]] && wget ${PETSC4PY_INSTALL_SCRIPT_DOWNLOAD} -O ${PETSC4PY_INSTALL_SCRIPT_PATH}
    source $PETSC4PY_INSTALL_SCRIPT_PATH

    # Download and uncompress library archive
    SLEPC4PY_ARCHIVE_PATH=${SLEPC4PY_ARCHIVE_PATH:-"SLEPC4PY_ARCHIVE_PATH_IN"}
    [[ $SLEPC4PY_ARCHIVE_PATH == http* ]] && SLEPC4PY_ARCHIVE_DOWNLOAD=${SLEPC4PY_ARCHIVE_PATH} && SLEPC4PY_ARCHIVE_PATH=/tmp/slepc4py-install.tar.gz && wget ${SLEPC4PY_ARCHIVE_DOWNLOAD} -O ${SLEPC4PY_ARCHIVE_PATH}
    if [[ $SLEPC4PY_ARCHIVE_PATH != skip ]]; then
        tar -xzf $SLEPC4PY_ARCHIVE_PATH --strip-components=$INSTALL_PREFIX_DEPTH --directory=$INSTALL_PREFIX
    fi

    # Mark package as installed
    mkdir -p $SHARE_PREFIX
    touch $SLEPC4PY_INSTALLED
fi
