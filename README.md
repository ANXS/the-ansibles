# The Ansibles

Mainly a (growing) collection of [ansible roles](roles/) I have been writing. I present them here for reuse and educational purposes, since extensive examples are currently sparse, and I would've benefited from these when I started out. I hope they'll benefit others now. They're targetted and tested for Ubuntu (precise), so might not work on all systems (at least not out of the box).

I have a couple of other ones, and will update the repository when I manage to clean them up. Meanwhile, feel free to send in pull requests with fixes, updates, new roles. I'll happily review and add them.

Some of the roles require some configuration (pre- or post-), so I added some [documentation](docs/). Do check these out if you don't want to waste time.

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
