#!/bin/sh
/etc/init.d/sssd stop
echo "Clearing sssd cache"
rm -f /var/lib/sss/db/*
rm -f /var/lib/sss/mc/*
echo "Done clearing sssd cache"
/etc/init.d/sssd start