# The Ansibles

Mainly a (growing) collection of [ansible roles](roles/) I have been writing. I present them here for reuse and educational purposes, since extensive examples are currently sparse, and I would've benefited from these when I started out. I hope they'll benefit others now. They're targetted and tested for Ubuntu (precise), so might not work on all systems (at least not out of the box).

I have a couple of other ones, and will update the repository when I manage to clean them up. Meanwhile, feel free to send in pull requests with fixes, updates, new roles. I'll happily review and add them.

Some of the roles require some configuration (pre- or post-), so I added some [documentation](docs/). Do check these out if you don't want to waste time.

## Roles included


Ordered alphabetically. Some have [instructions](docs/) (so *RTFM*).

| Role | Contents |
| --- | --- |
| cassandra | installs & configures [Cassandra](http://cassandra.apache.org/) |
| common | sets/makes/updates hostname, timezone, directories and apt AND installs & configures essentials (g++, build-essential, automake, ack, ...), tools (curl, debconf, [dmidecode](http://www.nongnu.org/dmidecode/), [htop](http://htop.sourceforge.net/), [iftop](http://www.ex-parrot.com/pdw/iftop/), iotop, [nmap](http://nmap.org/), [tshark](http://www.wireshark.org/docs/man-pages/tshark.html), [tmux](http://tmux.sourceforge.net/), [mosh](http://mosh.mit.edu/), ...), git, vim, cron, logwatch, tmpreaper, ssh and [pdns](https://www.powerdns.com/) |
| firewall | installs & configures [ferm](http://ferm.foo-projects.org/) - don't forget to update /etc/ferm/ferm.conf |
| java | installs JVM 'related' languages and tools ([Oracle JDK](http://docs.oracle.com/javase/), [Scala](http://www.scala-lang.org/), [Clojure](http://clojure.org/) & [Maven](http://maven.apache.org/)) |
| mail | installs & configures a *full-featured mailserver* with [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol) over SSL via [Postfix](http://www.postfix.org/), [IMAP](https://en.wikipedia.org/wiki/Internet_Message_Access_Protocol) over SSL via [Dovecot](http://dovecot.org/), Full-text search in your imbox powered by [solr](https://lucene.apache.org/solr/), [DNSBLs](https://en.wikipedia.org/wiki/DNSBL) to redirect spam even before it hits your filters, [DSPAM](http://dspam.sourceforge.net/) and [Postgrey](http://postgrey.schweikert.ch/) for spam-fencing and [OpenDKIM](http://www.opendkim.org/) mail server verification |
| monit | installs & configures [monit](http://mmonit.com/monit/) |
| mysql | installs, configures & hardens [MySql](http://dev.mysql.com/) |
| nginx | installs & configures [nginx](http://nginx.org/) - You can choose to install it through a package, or build it from source, and fine-tune which modules to ex/include |
| nodejs | installs [nodejs](http://nodejs.org/) - You can choose to install it through a package, or build it from source |
| python | installs python & dependencies (python, python-dev, libevent-dev, cython, python3) |
| security | installs & configures [fail2ban](http://www.fail2ban.org/), [rkhunter](http://rkhunter.sourceforge.net/) and [lynis](http://www.rootkit.nl/projects/lynis.html) |
| ssl | moves ssl certificates to the host (required for other playbooks) |
| supervisor | installs & configures [supervisord](http://supervisord.org/) |
| vpn | installs & configures [OpenVPN](http://openvpn.net/index.php/open-source.html) |
| znc | installs & configures [ZNC](http://wiki.znc.in/) IRC bouncer |
| zookeeper | installs & configures [Zookeeper](http://zookeeper.apache.org/) |


# Contrib

## Cloudbox

Inspired by inspired by [Drew Crawford](https://twitter.com/drewcrawford)'s [post](http://sealedabstract.com/code/nsa-proof-your-e-mail-in-2-hours/), and [al3x](https://twitter.com/al3x)'s [sovereign](https://github.com/al3x/sovereign/) repo, I have created a similarly complete set that gives you a personal (mail/web/...)server.

The set-up of the scripts are different (mainly because I recycled what I had + I have a slightly different approach so I there is a better fallback mechanism for default values), as is the content of what it installs (nginx instead of apache, no owncloud due to some nasty experiences with it in the past, ...)

I took the time to write a [**complete tutorial**](docs/cloudbox.md), which should get you up and running very quickly (the manual work is really limited to an absolute minimum).

## Vagrant

As a second example, everything is configured to work with vagrant (precise64) 'testbox' on 192.168.111.111. There's a Vagrantfile included in `contrib/vagrant/` for this configuration.

Try it out:

1. edit the `contrib/vagrant/Vagrantfile`, `contrib/vagrant/auth_vars`, and `host_vars/192.168.111.111` to your liking
2. `vagrant up`
3. `ansible-playbook -i vagrant setups/vagrant.yml --sudo`

## contrib/deprecated?

Scripts I've written, yet don't consider that useful to myself. Mainly here for reference purposes. Happy if they're useful to others.

# Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/pjan/the-ansibles/issues)! Everyone benefits, really...
