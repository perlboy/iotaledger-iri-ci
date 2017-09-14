#!/bin/bash

/usr/bin/gpg --no-use-agent --no-tty --passphrase-file /etc/jenkins.passphrase $@

