# The Ansibles

Mainly a (growing) collection of [ansible roles](roles/) I have been writing. I present them here for reuse and educational purposes, since extensive examples are currently sparse, and I would've benefited from these when I started out. I hope they'll benefit others now. They're targetted and tested for Ubuntu (precise), so might not work on all systems (at least not out of the box).

I have a couple of other ones, and will update the repository when I manage to clean them up. Meanwhile, feel free to send in pull requests with fixes, updates, new roles. I'll happily review and add them.

Some of the roles require some configuration (pre- or post-), so I added some [documentation](docs/). Do check these out if you don't want to waste time.

## Roles included


Ordered alphabetically. Some have [instructions](docs/) (so *RTFM*).

| Role | Contents |
| --- | --- |
| apt | updates the aptitude sources list, updates the cache, and upgrades all packages |
| auth | setting up users and groups |
| build | makes sure essential build/make/config/compiler packages (g++, build-essential, automake, ack, ...) are installed |
| cassandra | installs & configures [Cassandra](http://cassandra.apache.org/) |
| clojure | installs the [clojure](http://clojure.org/) language binaries |
| common | runs over dependency roles (hostname, timezone, directories, apt, vim, build, cron, logwatch, tmpreaper, ssh, powerdns) and installs a set of tools to help you manage a server (curl, debconf, [dmidecode](http://www.nongnu.org/dmidecode/), [htop](http://htop.sourceforge.net/), [iftop](http://www.ex-parrot.com/pdw/iftop/), iotop, [nmap](http://nmap.org/), [tshark](http://www.wireshark.org/docs/man-pages/tshark.html), [tmux](http://tmux.sourceforge.net/), [mosh](http://mosh.mit.edu/), ...) |
| cron | installs cron |
| directories | makes sure 'default' and 'additional' directories, and their auth settings, are present |
| elasticsearch | installs & configures [elasticsearch](http://www.elasticsearch.org/) |
| firewall | installs & configures [ferm](http://ferm.foo-projects.org/) - don't forget to update /etc/ferm/ferm.conf |
| jdk | installs [Oracle JDK](http://docs.oracle.com/javase/) binaries |
| [kafka](docs/kafka.md) | installs & configures [apache kafka](http://kafka.apache.org/) |
| [mail](docs/mail.md) | installs & configures a *full-featured mailserver* with [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol) over SSL via [Postfix](http://www.postfix.org/), [IMAP](https://en.wikipedia.org/wiki/Internet_Message_Access_Protocol) over SSL via [Dovecot](http://dovecot.org/), Full-text search in your imbox powered by [solr](https://lucene.apache.org/solr/), [DNSBLs](https://en.wikipedia.org/wiki/DNSBL) to redirect spam even before it hits your filters, [DSPAM](http://dspam.sourceforge.net/) and [Postgrey](http://postgrey.schweikert.ch/) for spam-fencing and [OpenDKIM](http://www.opendkim.org/) mail server verification |
| maven | installs the [Maven](http://maven.apache.org/) build manager for JVM language projects |
| monit | installs & configures [monit](http://mmonit.com/monit/) |
| mysql | installs, configures & hardens [MySql](http://dev.mysql.com/) |
| netatalk | installs & configures netatalk |
| nginx | installs & configures [nginx](http://nginx.org/) - You can choose to install it through a package, or build it from source, and fine-tune which modules to ex/include |
| nodejs | installs [nodejs](http://nodejs.org/) - You can choose to install it through a package, or build it from source |
| powerdns | installs & the configures [powerdns](https://www.powerdns.com/) dns recursor |
| python | installs python & dependencies (python, python-dev, libevent-dev, cython, python3) |
| scala | installs the [Scala](http://www.scala-lang.org/) language binaries |
| security | installs & configures [fail2ban](http://www.fail2ban.org/), [rkhunter](http://rkhunter.sourceforge.net/) and [lynis](http://www.rootkit.nl/projects/lynis.html) |
| ssh | configures (hardens!) the machines ssh |
| [ssl](docs/ssl.md) | moves (wildcard) ssl certificates to the host |
| storm | (common, drpc, nimbus, supervisor) installs & configures [twitter storm](http://storm-project.net/) |
| supervisor | installs & configures [supervisord](http://supervisord.org/) |
| timezone | sets the systems timezone |
| tmpreaper | installs and configures [tmpreaper] |
| vim | makes sure the 'right' version of vim is installed and configured |
| [vpn](docs/vpn.md) | installs & configures [OpenVPN](http://openvpn.net/index.php/open-source.html) |
| zeromq | installs [ØMQ](http://zeromq.org/) socket library |
| [znc](docs/znc.md) | installs & configures [ZNC](http://wiki.znc.in/) IRC bouncer |
| zookeeper | installs & configures [Zookeeper](http://zookeeper.apache.org/) |


## Requirements

- ansible > 1.3, and it's dependencies


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
3. `ansible-playbook -i vagrant vagrant.yml --sudo`

## contrib/deprecated?

Scripts I've written, yet don't consider that useful to myself. Mainly here for reference purposes. Happy if they're useful to others.

# Thanks

To all contributors:

* [Greg Tangey](https://github.com/Ruxton)
* [Tim Vandecasteele](https://github.com/tim-vandecasteele)

# Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/pjan/the-ansibles/issues)! Everyone benefits, really...
