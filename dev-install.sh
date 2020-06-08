#!/bin/bash

# Check required tools
[[ -z $(command -v python3) ]] && echo python not available && FAIL=1
[[ -z $(command -v pip3) ]] && echo python not available && FAIL=1
[[ -z $(command -v virtualenv) ]] && echo virtualenv not available && FAIL=1

[[ $FAIL ]] && echo && echo Build failed && exit 1

# Build Ansible Python environment
if [[ ! -d python ]] ; then
    virtualenv python
fi 

# shellcheck disable=SC1091
source python/bin/activate

pip install -r requirement.txt
