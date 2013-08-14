# WP-CLI Install
if [ ! -d /var/www/wp-cli ]
then
    printf "\nInstalling wp-cli\n"
    git clone git://github.com/wp-cli/wp-cli.git /var/www/wp-cli
    cd /var/www/wp-cli
    composer install
else
    printf "\nSkip wp-cli installation, already available\n"
fi
# Link wp to the /usr/local/bin directory
sudo ln -sf /var/www/wp-cli/bin/wp /usr/local/bin/wp