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
    cd ${pwd}/files
    cp -rf .emacs ~/
    cp -rf .emacs.d ~/

    echo "        Installing Cscope..."
    apt_install libncurses5-dev
    apt_install libncursesw5-dev
    make_install cscope*
    sudo cp ${tmp_dir}/cscope*/src/cscope /usr/bin/
    sudo cp ${tmp_dir}/cscope*/contrib/xcscope/cscope-indexer /usr/bin
    sudo chmod 755 /usr/bin/cscope-indexer
    sudo sed -i 's/cscope -b -i $LIST_FILE -f $DATABASE_FILE/cscope -q -b -i $LIST_FILE -f $DATABASE_FILE/' /usr/bin/cscope-indexer

    echo "        Installing auctex..."
    make_install auctex*
}

#
# editor
#
editor()
{
    latex;
    emacs;
}

#
# development
#
development()
{
    echo "Installing ruby1.9.3..."
    apt_install ruby1.9.3

    echo "Installing Git..."
    apt_install git

    echo "Installing ssh..."
    apt_install openssh-server
}

#
# environment
#
environment()
{
    # youdao dictionary
    echo "Installing youdao dictionary"
    echo ENTER > sudo add-apt-repository ppa:xdlailai/openyoudao #> /dev/null 2>&1
    sudo apt-get update #> /dev/null 2>&1
    apt_install openyoudao

    # spice - circuit simulation
    apt_install ngspice

    # input method
    # apt_install ibus
    # apt_install ibus-clutter
    # apt_install ibus-gtk
    # apt_install ibus-gtk3
    # apt_install ibus-qt4
    # im-switch -s ibus
    # apt_install ibus-googlepinyin
    # ibus-setup
    # ibus-daemon -drx

    # xmind
    # Firstly, install xmind(V3.4.1) from pan.baidu.com
    # following is how to upgrade to Pro version in free
    # 1: copy patch file to direction
    sudo cp files/net.xmind.verify_3.4.1.201401221918.jar /usr/local/xmind/plugins/ # this patch may be ONLY for V3.4.1
    # 2: click help -> license -> change license key, then input email and serial number
    # input serial number: "yisufuyou"(exclude character ")
}

#
# config
#
config()
{
    echo "Add thinkpad_init.sh to init shell"
    cp ./scripts/thinkpad_init.sh /etc/init.d/
    sudo chmod 755 /etc/init.d/thinkpad_init.sh
    sudo update-rc.d thinkpad_init.sh defaults 95 > /dev/null 2>&1
    sudo cp ./scripts/thinkpad_init.sh /etc/profile.d/
}

#
# Start installation and configuration
#
if [ -z "$1" ]; then
editor;
development;
environment;
config;
else
case $1 in
    editor)
	editor;;
    development)
	development;;
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

