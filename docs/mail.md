# Mail

## Before running the role:

The following commands will setup the on-disk encryption folders for your mailbox(es).


It is assumed that the common role has been pointed to the machine, before you run these commands. If not, make sure encfs/fuse are installed (`sudo apt-get install encfs libfuse-dev fuse-utils`).

```bash
mkdir /srv/data/mail
mkdir /srv/data/mail/encrypted /srv/data/mail/decrypted
groupadd -g 3020 vmail
useradd -d /srv/data/mail/decrypted -u 3020 -g 3020 vmail
chgrp vmail /srv/data/mail/decrypted/
chmod -R g+rw /srv/data/mail/decrypted/
gpasswd -a vmail fuse
chgrp fuse /dev/fuse; chmod g+rw /dev/fuse
encfs /srv/data/mail/encrypted /srv/data/mail/decrypted --public
```

Now, select P, and type the password of your choosing twice. Be sure not to forget this one, as it might lock your email for all eternity if you do!


## Configuration

### Password variables

The passwords in the configuration must be SHA-512 ($6$) hashes. The quickest way to get these, is pointing your browser to [quickhash](https://quickhash.com/) and generate them there.

**Pro-tip:** using a random salt makes it even safer.


### Setting up your DNS

#### Basic entries (whenever):
Direct the following DNS entries to your <IP>

```
mail.domain.com
smtp.domain.com
```

#### Reverse PTR
Login to your hosting providers dashboard, and set the reverse PTR setting.


#### SPF (whenever):
Add a 300 TXT entry with the following content:

```
v=spf1 mx -all
```

#### DKIM (post-install):
ssh into the machine, anc change into `/etc/opendkim/keys/`

For every of the subdirectories (= subdomains), there's a default.txt. For every one of them:

```
cat default.txt
```

and put the info in a TXT DNS record.


## Debugging


### The mail configuration (headers, dkim, ...):
Just follow the steps presented [here](http://www.brandonchecketts.com/emailtest.php)


### Debug the full-text search:
```bash
openssl s_client -connect localhost:993
. login [email] [password]
. Select "Inbox"
. Search text "test"
```
