# via http://blakewilliams.me/blog/4-system-wide-rbenv-install

if [ ! -d /usr/local/rbenv ]; then

    echo "Installing rbenv build dependencies (make, openssl, readline, zlib)"
    #
    apt-get install -y make
    apt-get install -y libssl-dev
    apt-get install -y libreadline-dev
    apt-get install -y zlib1g-dev
    apt-get install -y build-essential 
    apt-get install -y g++

    echo "Installing rbenv"
    #
    cd /usr/local
    git clone git://github.com/sstephenson/rbenv.git rbenv
    chgrp -R admin rbenv
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
    chgrp -R admin ruby-build
    chmod -R g+rwxs ruby-build

    echo "Installing rbenv-binstubs"
    #
    mkdir -p /usr/local/rbenv/plugins
    if [ ! -d /usr/local/rbenv/plugins/rbenv-binstubs ]; then
        cd /usr/local/rbenv/plugins
        git clone https://github.com/ianheggie/rbenv-binstubs.git
        chgrp -R admin rbenv-binstubs
        chmod -R g+rwxs rbenv-binstubs
    fi

    echo "Installing Ruby 2.0.0-p0"
    rbenv install 2.0.0-p0
    
    echo "Installing Bundler"
    gem install bundler
    rbenv rehash

    echo "Setting rbenv global version to Ruby 2.0.0-p0"
    rbenv global 2.0.0-p0
fi
