# via http://blakewilliams.me/blog/4-system-wide-rbenv-install

if [ ! -d /usr/local/rbenv ]; then

    echo "Installing rbenv build dependencies (make, openssl, readline, zlib)"
    #
    apt-get install make
    apt-get install libssl-dev
	apt-get install libreadline-dev
	apt-get install zlib1g-dev

    echo "Installing rbenv"
    #
	cd /usr/local
	git clone git://github.com/sstephenson/rbenv.git rbenv
	chgrp -R staff rbenv
	chmod -R g+rwxXs rbenv

    echo "Adding rbenv init to /home/vagrant/.profile"
    #
	echo 'export RBENV_ROOT=/usr/local/rbenv' >> /home/vagrant/.profile
	echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /home/vagrant/.profile
	echo 'eval "$(rbenv init -)"' >> /home/vagrant/.profile

    echo "Adding rbenv init to /root/.profile"
	echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.profile
	echo 'export PATH="$RBENV_ROOT/bin:$PATH"' >> /root/.profile
	echo 'eval "$(rbenv init -)"' >> /root/.profile
	source /root/.profile

	echo "Installing ruby-build"
	#
	cd /usr/local/rbenv
	mkdir plugins
	cd plugins
	git clone git://github.com/sstephenson/ruby-build.git
	chgrp -R staff ruby-build
	chmod -R g+rwxs ruby-build

	echo "Installing Ruby 2.0.0-p0"
	rbenv install 2.0.0-p0

	echo "Setting rbenv global version to Ruby 2.0.0-p0"
	rbenv global 2.0.0-p0
fi