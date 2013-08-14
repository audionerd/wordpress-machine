echo "Installing PHPUnit"
echo "Hold on, this may take a short while..."
echo ""
sudo pear config-set auto_discover 1
sudo pear upgrade PEAR
sudo pear install pear.phpunit.de/PHPUnit