
pma_version="3.5.8.1"
pma_filename="phpMyAdmin-$pma_version-all-languages"

cd /var/www

if [ ! -d "$pma_filename" ]; then
    echo "Installing phpMyAdmin"
    echo "Downloading version $pma_version..."
    wget -q http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/$pma_version/$pma_filename.tar.bz2
    echo "Extracting package"
    tar xf $pma_filename.tar.bz2
    rm $pma_filename.tar.bz2
    echo "Done."
fi

if [ ! -L pma ]; then
    ln -s $pma_filename pma
fi
