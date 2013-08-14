
# include the WP versions you wish to be installed
versions_to_create=(
    3.1
    3.2
    3.3
    3.4
    3.5
    3.5.1
    3.5.2
)

if [ ! -d /var/www/wp ]; then
    mkdir -p /var/www/wp
fi

cd /var/www/wp

mysqlUser="root"
mysqlPassword="blank"
mysqlCmd="mysql -u $mysqlUser -p$mysqlPassword -B -N"

echo "Installing WordPress environment"
echo ""

if [ ! -f /var/www/wp/info.php ]; then
cat > info.php << EOF
<?php
phpinfo();
EOF
fi

for version in ${versions_to_create[@]}
do
    cd /var/www/wp

    dbname=`echo "wp_$version" | sed 's/\./_/g'`

    db_exist=$($mysqlCmd -e "SHOW DATABASES LIKE '$dbname'")

    if [ "" == "$db_exist" ]
    then
        echo ""
        echo "Installing WP version $version"
        echo "------------------------------"
        echo ""

        $mysqlCmd -e "CREATE DATABASE IF NOT EXISTS $dbname"
        # this creates the user if it does not exist:
        $mysqlCmd -e "GRANT ALL PRIVILEGES ON $dbname.* TO 'wp'@'localhost' IDENTIFIED BY 'wp'"

    
        if [ ! -d "$version" ]; then
            echo "Downloading package..."
            wget -q http://wordpress.org/wordpress-$version.tar.gz
            echo "Extracting..."
            tar xf wordpress-$version.tar.gz
            mv wordpress $version
            if [ -f "wordpress-$version.tar.gz" ]; then
                rm wordpress-$version.tar.gz
            fi

            cd $version
        fi

        if [ -f wp-config.php ]; then
            rm wp-config.php
        fi

        echo "Installing..."
        wp core config --dbname=$dbname --dbuser=wp --dbpass=wp --extra-php <<PHP
define( "WP_DEBUG", true );
define( "WP_DEBUG_LOG", true );
PHP
        
        wp core install --url=wp.dev/$version --quiet --title="wp.dev $version" --admin_name=admin --admin_email="admin@wp.dev" --admin_password="123"

        # if [ -f /vagrant/database/$dbname.sql ]
        # then
        #     $mysqlCmd $dbname < /vagrant/database/$dbname.sql
        # fi

        if [ ! -d "./../wp-content" ]; then
            mkdir ./../wp-content
            mkdir ./../wp-content/languages
            mkdir ./../wp-content/plugins
            mkdir ./../wp-content/themes
            mkdir ./../wp-content/uploads
            touch ./../wp-content/debug.log
        fi

        if [ -d "wp-content" ]; then
            if [ -d "wp-content/languages" ]; then
                cp -Rf wp-content/languages/* ../wp-content/languages/
            fi
            cp -Rf wp-content/themes/* ../wp-content/themes/
            cp -Rf wp-content/plugins/* ../wp-content/plugins/
            rm -Rf wp-content
        fi

        if [ ! -L "wp-content" ]; then
            ln -s ../wp-content wp-content
        fi

        echo "Done."

    else
        echo "WP version $version already installed"
    fi

    echo ""

done

echo "Finished installing WP versions"
echo ""
