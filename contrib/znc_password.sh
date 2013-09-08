#!/bin/bash

ZNC_PASS=$1

ZNC_SALT="$(dd if=/dev/urandom bs=16c count=1 | md5sum | awk '{print $1}')"
ZNC_HASH="sha256#$(echo -n ${ZNC_PASS}${ZNC_SALT} | sha256sum | awk '{print $1}')#$ZNC_SALT#"

echo $ZNC_HASH
