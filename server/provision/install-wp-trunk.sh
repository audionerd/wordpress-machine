# Checkout, install and configure WordPress trunk
if [ ! -d /var/www/wp/trunk ]
then
    echo "Checking out WordPress trunk from http://core.svn.wordpress.org/trunk"
    svn checkout http://core.svn.wordpress.org/trunk/ /var/www/wp/trunk
    cp -R /var/www/wp/trunk/wp-content/themes/* /var/www/wp/wp-content/themes/

    cd /var/www/wp/trunk

    mysqlUser="root"
    mysqlPassword="blank"
    mysqlCmd="mysql -u $mysqlUser -p$mysqlPassword -B -N"
    dbname="wp_trunk"

    $mysqlCmd -e "CREATE DATABASE IF NOT EXISTS $dbname"
    # this creates the user if it does not exist:
    $mysqlCmd -e "GRANT ALL PRIVILEGES ON $dbname.* TO 'wp'@'localhost' IDENTIFIED BY 'wp'"

    wp core config --dbname=$dbname --dbuser=wp --dbpass=wp --extra-php <<PHP
define( "WP_DEBUG", true );
define( "WP_DEBUG_LOG", true );
PHP

    wp core install --url=wp.dev/trunk --quiet --title="wp.dev trunk" --admin_name=admin --admin_email="admin@wp.dev" --admin_password="123"

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

else
    echo "Updating WordPress trunk...\n"
    cd /var/www/wp/trunk
    svn up --ignore-externals
fi