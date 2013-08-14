# fake the wp directory for now, to make Apache happy
mkdir /var/www/wp

# override wordpress location to point to our site
sudo ln -s /vagrant/site /var/www/site

# run Wordpress setup scripts
cd /var/www/site

source script/setup
cd /var/www/site

# remove the wp stuff for now
if [ ! -L /etc/apache2/sites-enabled/wp ]; then
    rm /etc/apache2/sites-enabled/wp
fi

# enable this site
if [ ! -L /etc/apache2/sites-enabled/site ]; then
	sudo ln -s /vagrant/sites-available/site.vhost /etc/apache2/sites-enabled/site
fi

# setup gems
cd /var/www/site
gem install bundler
rbenv rehash
bundle install --binstubs .bundle/bin
rbenv rehash

sudo service apache2 restart
