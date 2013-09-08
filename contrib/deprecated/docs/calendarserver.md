The filesystem where calendarserver (caldavd) will store its data needs to have extended user attributes enabled, since it stores a lot of data about individual calendars in extended attributes. I put mine in /home/caldavd, since that's the user who the server runs as.

A word of caution... If you aren't familiar with configuring filesystems, check man mount or search online for help before following the next few steps. The following is not a complex task, but don't mess around with your filesystem if you're guessing. You won't be happy if you mess up.
# Make a backup of /etc/fstab before you mess with it.  It's an important file!
$ sudo vi /etc/fstab
and add the 'user_xattr' flag to whichever filesystem you plan to use.
# /dev/md1
# user_xattr only for caldavd, apple calendar server
UUID=1aaecc3a-5da5-4abc-a25d-bfb11963cda6 /home   ext3 relatime,user_xattr  0  2
Your /etc/fstab may look totally different. The only relevant bit of information is that you need to add 'user_xattr' to the 4th column of data. Leave the rest alone. For more information on the UUID part, read http://www.unixtutorial.org/2008/05/ubuntu-uuid-how-to/
Now you need to remount the filesystem.
$ sudo mount -o remount <device>
where <device> is whichever device file (in /dev somewhere) which corresponds to your mount point (the thing you changed in /etc/fstab).


mkdir /srv/data/dav

mkdir /srv/data/dav/encrypted /srv/data/dav/decrypted
groupadd -g 3021 caldavd
useradd -d /srv/data/mail/decrypted -u 3021 -g 3021 caldavd
chown caldavd:caldavd /srv/data/mail/decrypted/
chmod -R +rw /srv/data/mail/decrypted/
gpasswd -a caldavd fuse
chgrp fuse /dev/fuse; chmod g+rw /dev/fuse
encfs /srv/data/mail/encrypted /srv/data/mail/decrypted --public

> Select P

And type the password, twice
