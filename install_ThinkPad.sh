#! /bin/sh

pwd=`pwd`
tmp_dir=`pwd`/tools/tmp

# dead work
mkdir ${tmp_dir} > /dev/null 2>&1

make_install()
{
    cd ${pwd}/tools;
    tar -xzf $1 -C ${tmp_dir};
    cd ${tmp_dir}/$1;
    ./configure > /dev/null 2>&1;
    make > /dev/null 2>&1;
    sudo make install > /dev/null 2>&1;
    cd ${pwd};
}

apt_install()
{
    echo y |  sudo apt-get install $1 > /dev/null 2>&1;
}

#
# Latex
#
latex()
{
    echo "Install LaTex..."
    apt_install texlive-latex-base
    apt_install latex-cjk-all
    apt_install texlive-latex-extra
}

#
# Emacs
#
emacs()
{
    echo "Install and config Emacs..."
    echo "        Installing Emacs..."
    apt_install emacs23
    echo "        Configing Emacs..."
    cd ${pwd}/emacs
    cp -rf .emacs ~/
    cp -rf .emacs.d ~/

    echo "        Installing Cscope..."
    make_install cscope*
    sudo cp ${tmp_dir}/cscope*/src/cscope /usr/bin/
    sudo cp ${tmp_dir}/cscope*/contrib/xcscope/cscope-indexer /usr/bin
    sudo chmod 755 /usr/bin/cscope-indexer
    sudo sed -i 's/cscope -b -i $LIST_FILE -f $DATABASE_FILE/cscope -q -b -i $LIST_FILE -f $DATABASE_FILE/' /usr/bin/cscope-indexer

    echo "        Installing auctex..."
    make_install auctex*
}

#
# environment
#
environment()
{
    echo "Installing ruby1.9.3..."
    apt_install ruby1.9.3

    echo "Installing Git..."
    apt_install git

    echo "Installing ssh..."
    apt_install openssh-server
}

#
# config
#
config()
{
    echo "TODO: Some configurations need to be done"
}

if [ -z "$1" ]; then
latex;
emacs;
environment;
config;
else
case $1 in
    latex)
	latex;;
    emacs)
	emacs;;
    environment)
	environment;;
    config)
	config;;
    *)
	echo "Please check your first argument: $1"
esac
fi

rm -rf ${tmp_dir}

exit 0

