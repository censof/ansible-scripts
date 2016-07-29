Role Name
=========

A role to run installation of Apache binary.

Requirements
------------

Ansible 2.0.0.2

Example Usage
-------------

1. ansible-playbook -i hosts tasks/main.yml --ask-pass --skip-tags "finalize"
2. ansible-playbook -i hosts tasks/main.yml --ask-pass --skip-tags "install, finalize"
3. ansible-playbook -i hosts tasks/main.yml --ask-pass --tags "finalize"

License
-------

BSD

Author Information
------------------

Censof Sys Admin
