# Wordpress Machine

Wordpress Machine provides a boilerplate setup for Wordpress on a LAMP stack running under Vagrant.  

The Wordpress core is included as a submodule.  
This makes Wordpress updates reasonably quick (just a submodule checkout + commit + deploy).

Included stack:

* LAMP
* Ruby 2.0 via rbenv
* screenfetch
* composer
* phpMyAdmin
* [Forge](http://forge.thethemefoundry.com/) for Wordpress theme setup and asset compilation (SCSS, CoffeeScript)
* [wp-cli](http://wp-cli.org/) for command-line scripting of Wordpress. This allows us to seed content, import/export content between environments, and more.
* Provisioning scripts via [ifeelweb/ifwWordPressDevEnvironment](https://github.com/ifeelweb/ifwWordPressDevEnvironment)
* Wordpress as a submodule via [Darep/wordpress-boilerplate](http://ajk.fi/2013/wordpress-as-a-submodule)



### How-To for Designers

#### Getting Started

You'll need a few programs installed on your machine:

Install Vagrant (http://downloads.vagrantup.com/)  
Install VirtualBox (https://www.virtualbox.org/wiki/Downloads)

Clone the Wordpress Machine repo from GitHub (or ask for a ZIP'd copy, that works too).

Open `Terminal.app`, and change to the directory (`cd`) where the code is extracted and the `Vagrantfile` resides. You can drag-and-drop this folder from Finder to the Terminal window to insert the full path.

For example:

    cd ~/Documents/Projects/wordpress-site

Now startup Vagrant:

	vagrant up

This will take about 20 minutes. Vagrant is creating a virtual machine with Wordpress running on it, and configuring the site.

Once this process is complete, browse to `192.168.33.10` (the IP address of the virtual machine now running on your computer), e.g.:

	open http://192.168.33.10

Or for Wordpress admin:

	open http://192.168.33.10/wp-admin

Wordpress Admin Login:

* username: **admin**
* password: **password**

#### Modifying the Theme Design

Log in to your virtual machine using SSH, e.g.:

    cd ~/Documents/Projects/wordpress-site
	vagrant ssh	

On this virtual machine, everything in your local `wordpress-site` folder shows up in the VM's `/vagrant` folder.

So, within the VM, switch directories to the site theme, e.g.:

	vagrant ssh
	cd /vagrant/site/site-theme

NOTE: If you don't have a Forge-generated `site-theme`, you can create one, with:

	vagrant ssh
	cd /vagrant/site
	script/run

If you have a Forge-generated `site-theme` already, you can copy it into `~/Documents/Projects/wordpress-site/site/site-theme` and run Forge, which compiles SCSS for us:

	vagrant ssh
	cd /vagrant/site/site-theme
	forge watch

Now Forge is watching any changes you make, and will apply them to the site theme automatically.

Try making CSS changes to `site/site-theme/source/_site.scss`, and you should see them update

#### Saving your changes to the Git repository

### Tech Notes

Wordpress is served out of `site/`  

Wordpress theme goes in `site/site-theme` and `forge watch` auto-publishes to `wordpress/wp-content/themes/site-theme`. (See Forge docs for more info on how this works).  

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

DB setup and seed with test content _automagically_!

Wordless (HAML) w/ Ruby installed in VM

Automatic hosts setup via:

	https://github.com/cogitatio/vagrant-hostsupdater
	Vagrant.require_plugin "vagrant-hostsupdater"

Use .env environment variables instead of hardcoding wordpress db config!
Extract site-specific config to its own file?  

Wercker CI to auto-build/test w/ Vagrant on every deploy?
