# The cloudbox

## Background

Inspired by inspired by [Drew Crawford](https://twitter.com/drewcrawford)'s [post](http://sealedabstract.com/code/nsa-proof-your-e-mail-in-2-hours/), and [al3x](https://twitter.com/al3x)'s [sovereign](https://github.com/al3x/sovereign/) repo, I have created a similarly complete set that gives you a personal (mail/web/...)server.

The set-up of the scripts are different (mainly because I recycled what I had + I have a slightly different approach so I there is a better fallback mechanism for default values), as is the content of what it installs (nginx instead of apache, no owncloud due to some nasty experiences with it in the past, ...)


## What's included

If you deploy this as-is on a Server/VPS/... you get

- a bunch of tools that make server management easier ([htop](http://htop.sourceforge.net/), [iftop](http://www.ex-parrot.com/pdw/iftop/), [nmap](http://nmap.org/), [tshark](http://www.wireshark.org/docs/man-pages/tshark.html), [tmux](http://tmux.sourceforge.net/), ...)
- a set of security related services ([fail2ban](http://www.fail2ban.org/) for intrusion prevention, [lynis](http://www.rootkit.nl/projects/lynis.html) for security auditing, [rkhunter](http://rkhunter.sourceforge.net/) for rootkit detection)
- [monit](http://mmonit.com/monit/) which keeps everything running properly
- an [nginx](http://nginx.org/) webserver, fully configurable with packages (if you decide to build it from source)
- a locked-down [mysql](http://www.mysql.com/) server, which will power authentication and virtual domains of your mailserver
- a complete mailserver (inspired by [Drew Crawford](https://twitter.com/drewcrawford)'s [post](http://sealedabstract.com/code/nsa-proof-your-e-mail-in-2-hours/)):
  - [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol) over SSL via [Postfix](http://www.postfix.org/)
  - [IMAP](https://en.wikipedia.org/wiki/Internet_Message_Access_Protocol) over SSL via [Dovecot](http://dovecot.org/)
  - Postfix rules that will mask your IP & mail-agent
  - Full-text search in your imbox powered by [solr](https://lucene.apache.org/solr/)
  - [DNSBLs](https://en.wikipedia.org/wiki/DNSBL) to redirect spam even before it hits your filters
  - [DSPAM](http://dspam.sourceforge.net/) and [Postgrey](http://postgrey.schweikert.ch/) doing the spam-fencing
  - [OpenDKIM](http://www.opendkim.org/) mail server verification
  - Encrypted on-disk storage through [EncFS](http://www.arg0.net/encfs/)
- [EncFS](http://www.arg0.net/encfs/) to encrypt data on disk
- A private VPN Server via [OpenVPN](http://openvpn.net/index.php/open-source.html)
- [ZNC](http://wiki.znc.in/) to keep your IRC chat sessions open and secure
- A firewall through iptables & [ferm](http://ferm.foo-projects.org/)

Off course, you're free to add some of the other ansible roles to tweak your setup (and increase it's level of awesomeness), but that's up to you. Make sure you take into account that this might require you to change your ferm configuration file as well!

Currently missing are a good CalDAV/CardDAV solution, but all of the ones I tested currently failed my expectations for smooth operation (mainly: allowing encryption & being fully and flawlessly compatible with Apple Calendar & Contacts). I'm sure I haven't tested all of them, and am happy to accept suggestions, but even happier if you send me some pull-requests.


## Tutorial

### Requirements:

1. A server/host/vps with sudo/root access, running Ubuntu. I tested it on both DigitalOcean's and Linode's smallest offerings, and encountered zero issues, which means you can get all of this goodness for just $5 a month. (I'm based in APAC, for which Digital Ocean's latency kind of sucked, so I stuck with the linode instance).
2. A set of SSL wildcard crt/key/pem. You can buy them, or save some money by self-signing them (more info on how you do this can be found [here](docs/ssl.md)).


### Before you start:

Unfortunately, it still isn't a one-click solution, but we're getting close :-). If you follow these instructions, you should not face major difficulties. Make sure to have the following information/variables before you start (I will be using them throughout the instructions, so do replace it):

```
<IP>      your host's IP-address
<RA_USER> a user that has root/passwordless sudo access to the machine
<USER>    a user that has sudo access to the machine. This can be the same as the user above, but it cannot be root anymore (if that was the case)
```

1. Put the content of the SSL files in `roles/ssl/files/wildcard` directory. You can reuse the pem for your ZNC and put it in `roles/ssl/files/znc` or create and self-sign a new one ([same instructions](docs/ssl.md)).

2. Run through `host_vars/cloudbox` replace the variables as you feel necessary (the required ones are marked with TODO, including the required type). All possible options are marked in the `group_vars/` files if you want additional tweaking. (In that case, you should copy the lines and put them in the `host_vars/cloudbox` file, where you edit them.) Some need to be computed. Follow the instructions to see how:
  - [auth_vars](auth.md) configuration: `passwd`
  - [mail](mail.md): `password_hash`
  - [ZNC](znc.md): `Pass`

3. Change the filename of `host_vars/cloudbox` to `<IP>`. At the same time, change the second line of `cloudbox` to `<IP>` as well. (Adding other roles to the configuration is done through these 2 too, as well as through `setups/cloudbox_2.yml`).

4. Review the firewall rules in `roles/firewall/files/etc_ferm_ferm.conf`. They are configured for exactly this install, but it is always wise to check whether all of this is correct.

### Provisioning

1. Make sure you can ssh passwordless into the machine (cf. ssh-copy-id ...)

2. Point the first part of your ansible setup to the machine:

  ```
ansible-playbook -i cloudbox setups/cloudbox_1.yml -u <RA_USER> --sudo
```

3. ssh into the machine, and setup the on-disk encryption for your mail. Instructions can be found [here](mail.md).

4. Point the second part of your ansible setup to the machine:

  ```
ansible-playbook -i cloudbox setups/cloudbox_2.yml -u <USER> --sudo (--ask-sudo-pass)
```

### Post-install

1. OpenVPN needs a bit of manual configuration. It's easy though: follow [the instructions](vpn.md). Same for [mail](mail.md).

2. Reboot the machine.

3. Further customization? Maybe some [dotfiles](https://github.com/pjan/ubuntu-dotfiles) to get you started? (shameless plug)

# Feedback, bug-reports, requests, ...

Are [welcome](https://github.com/pjan/the-ansibles/issues)! Everyone benefits, really...
