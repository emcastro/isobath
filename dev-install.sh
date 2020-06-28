#!/bin/bash

set -e

# Check required tools
[[ -z $(command -v python3) ]] && echo python not available && FAIL=1
[[ -z $(command -v pip3) ]] && echo python not available && FAIL=1
[[ -z $(command -v virtualenv) ]] && echo virtualenv not available && FAIL=1

[[ $FAIL ]] && echo && echo Build failed && exit 1

# Build Ansible Python environment
if [[ ! -d python ]] ; then # if directory `python` does not exist
    virtualenv python
fi 

# shellcheck disable=SC1091
source python/bin/activate

pip install -r requirement-dev.txt
pip install -r requirement.txt

ansible-playbook -i ansible/local_inventory.yml ansible/setup_playbook.yml