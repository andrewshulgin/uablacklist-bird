#!/bin/bash

set -eo pipefail

curl -s --fail 'https://uablacklist.net/subnets.txt' | sed 's_.*_route & reject;_' > /etc/bird/subnets.txt
/usr/sbin/birdc configure;
