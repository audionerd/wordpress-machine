# COMPOSER
#
# Install or Update Composer based on expected hash from repository
if composer --version | grep -q 'Composer version e4b48d39d';
then
	printf "Composer already installed\n"
elif composer --version | grep -q 'Composer version';
then
	printf "Updating Composer...\n"
	composer self-update
else
	printf "Installing Composer...\n"
	curl -sS https://getcomposer.org/installer | php
	chmod +x composer.phar
	mv composer.phar /usr/local/bin/composer
fi