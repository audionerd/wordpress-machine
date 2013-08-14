# Wordpress Machine

This provides a boilerplate setup with Vagrant + Wordpress Core as a submodule
Wordpress updates are reasonably quick (just a submodule checkout + commit + deploy)

### LOCAL DEVELOPMENT

Install Vagrant (http://downloads.vagrantup.com/)

Install VirtualBox (https://www.virtualbox.org/wiki/Downloads)

Download the ZIP, or
`git clone` the repo and `git submodule update` to pull Wordpress core.

Then:

	$ cd server
	$ vagrant up

Setup will take about 20 minutes. Once complete, you can load up the server:

	$ open http://192.168.33.10

Wordpress is served out of `site/`

You can also setup /etc/hosts to point to subdomains so you can do:

	http://site.dev

Add these records to your local machine's hosts file
    * `192.168.33.10  site.dev`
    * `192.168.33.10  wp.dev`
    * `192.168.33.10  pma.dev`

(PMA = phpMyAdmin)

(see https://github.com/ifeelweb/ifwWordPressDevEnvironment for details)

### REFERENCES

Wordpress provisioning scripts via:
	https://github.com/ifeelweb/ifwWordPressDevEnvironment

Wordpress Boilerplate + Git submodule setup via:
	http://ajk.fi/2013/wordpress-as-a-submodule
	https://github.com/Darep/wordpress-boilerplate

Alternate Chef setup is also possible, see:
	https://github.com/thirdwavellc/vagrant-chef-wordpress

### TODO

DB is setup and seeded with test content _automagically_!

Wordless (HAML) w/ Ruby installed in VM

Automatic hosts setup via:
	https://github.com/cogitatio/vagrant-hostsupdater
	Vagrant.require_plugin "vagrant-hostsupdater"

Use .env environment variables instead of hardcoding wordpress db config!
Extract site-specific config to its own file?