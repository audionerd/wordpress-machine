# ifw WordPress Dev Environment

This is the environment I use for developing WordPress plugins. Its goal is to test my projects in various WordPress versions without having to install and maintain my files in every installation.

It uses [Vagrant](http://vagrantup.com) and [VirtualBox](http://virtualbox.org) to setup a virtual server environment with several WordPress versions (including the current beta version) you can test your product against.

It is inspired by [Varying Vagrant Vagrants](https://github.com/10up/varying-vagrant-vagrants)

## Getting Started

1. You can use it on any operating system. Vagrant and VirtualBox have installation packages for Windows, OSX and Linux.
1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
1. Install [Vagrant](http://downloads.vagrantup.com/)
1. Clone this repository into a local directory
    * `git clone https://github.com/ifeelweb/ifwWordPressDevEnvironment.git wp-dev-local`
1. Change into the new directory
    * `cd wp-dev-local`
1. Start the Vagrant environment
    * `vagrant up`
    * Be patient, this could take a while, especially on the first run.
1. Add these records to your local machine's hosts file
    * `192.168.33.10  wp.dev`    
    * `192.168.33.10  pma.dev`    
1. Visit `http://wp.dev/3.5.2` in your browser to load WordPress version 3.5.2. To load others versions, change the version in the URL, like to `3.1` / `3.2` and so on or enter `http://wp.dev/trunk` to load the current WordPress beta version.
1. A copy of phpMyAdmin will be available on `http://pma.dev/`

## Custom configuration

If you want to set custom configuration in the Vagrantfile, just place another file called `Customfile` in the directory where Vagrantfile is located an put your Vagrant configurations there.

For loading a custom provision script, eg. for symlinking your plugin or theme project on your host machine to the virtual environment, place a file called `custom-setup.sh` in the directory `provision`. It will be loaded after all provisioning is done.

## Development

All WordPress installations are located at `/var/www/wp/`. They share their `wp-content` folder which is moved to `/var/www/wp/wp-content`. If you link your plugin or theme sources to `/var/www/wp/wp-content/plugins` respectively `/var/www/wp/wp-content/themes` you can access them from all available WordPress versions without having to maintain your files in each version. 

To be able to access your project on your local machine you can add a new Vagrant synced folder to the `Customfile` like 
`config.vm.synced_folder "/path/to/project/on/host", "/vagrant/your-project"`

Then create a symlink on the virtual machine like 
`ln -s /vagrant/your-project /var/www/wp/wp-content/plugins/your-project`
and place this line in `provision/custom-setup.sh` for automatically loading it next time you `vagrant up` your environment.

## Environment

1. [Ubuntu](http://ubuntu.com) 12.04 LTS (Precise Pangolin)
1. [apache](http://httpd.apache.org/) 2.2.22
1. [mysql](http://mysql.com) 5.5.31
1. [php5](http://php.net) 5.3.10
1. [PHPUnit](http://pear.phpunit.de/) 3.7.21
1. [git](http://git-scm.com) 1.8.3
1. [subversion](http://subversion.apache.org/) 1.7.9
1. [Composer](https://github.com/composer/composer)
1. [WP-CLI](http://wp-cli.org)
1. [WordPress 3.1](http://wordpress.org) `http://wp.dev/3.1`
1. [WordPress 3.2](http://wordpress.org) `http://wp.dev/3.2`
1. [WordPress 3.3](http://wordpress.org) `http://wp.dev/3.3`
1. [WordPress 3.4](http://wordpress.org) `http://wp.dev/3.4`
1. [WordPress 3.5](http://wordpress.org) `http://wp.dev/3.5`
1. [WordPress 3.5.1](http://wordpress.org) `http://wp.dev/3.5.1`
1. [WordPress 3.5.2](http://wordpress.org) `http://wp.dev/3.5.2`
1. [WordPress trunk](http://core.svn.wordpress.org/trunk) `http://wp.dev/trunk`
1. [phpmyadmin](http://www.phpmyadmin.net/) `http://pma.dev/` (Login with MySQL root credentials)

## Credentials

### WordPress

All WordPress installations have the same credentials

* DB User: `wp`
* DB Pass: `wp`
* Admin User: `admin`
* Admin Pass: `123`

### MySQL
* MySQL root user: `root`
* MySQL root password: `blank`

## Feedback

If you have any questions please [contact](http://www.ifeelweb.de/contact/) me.

Looking for a quality WordPress plugin to get notified about post status changes? Try our [Post Status Notifier](http://www.ifeelweb.de/wp-plugins/post-status-notifier/) ;-)