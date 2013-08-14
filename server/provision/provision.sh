sudo apt-get update

sudo apt-get -y install apache2
sudo sh -c 'echo "ServerName localhost" >> /etc/apache2/conf.d/name'

echo mysql-server-5.5 mysql-server/root_password password blank | sudo debconf-set-selections
echo mysql-server-5.5 mysql-server/root_password_again password blank | sudo debconf-set-selections
sudo apt-get -y install mysql-server

sudo apt-get -y install php5

sudo apt-get -y install libapache2-mod-php5
sudo apt-get -y install php5-mysql

sudo apt-get -y install php-pear
sudo apt-get -y install php5-xdebug
sudo apt-get -y install curl
sudo apt-get -y install unzip
# sudo apt-get -y install subversion
sudo apt-get -y install git
sudo apt-get -y install vim

# activate mod_rewrite
if [ ! -L /etc/apache2/mods-enabled/rewrite.load ]; then
    sudo ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load
fi

# load vhosts
if [ ! -L /etc/apache2/sites-enabled/wp ]; then
    sudo ln -s /vagrant/sites-available/wp.vhost /etc/apache2/sites-enabled/wp
fi
if [ ! -L /etc/apache2/sites-enabled/pma ]; then
    sudo ln -s /vagrant/sites-available/pma.vhost /etc/apache2/sites-enabled/pma
fi

# symlink www
sudo rm -rf /var/www
mkdir /var/www
# sudo ln -s /vagrant/www /var/www

# install composer
bash /vagrant/provision/install-composer.sh

# install phpunit
bash /vagrant/provision/install-phpunit.sh

# install wp-cli
bash /vagrant/provision/install-wp-cli.sh

# install wp dev
# bash /vagrant/provision/install-wp-dev.sh

# install / update wordpress trunk
# bash /vagrant/provision/install-wp-trunk.sh

# install phpMyAdmin
bash /vagrant/provision/install-pma.sh

# install Ruby
bash /vagrant/provision/install-ruby.sh

if [ -f /vagrant/provision/custom-setup.sh ]; then
    bash /vagrant/provision/custom-setup.sh
fi

# finally restart/reload apache
sudo service apache2 restart


