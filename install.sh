#! /bin/sh

pwd=`pwd`
tmp_dir=`pwd`/tools/tmp
black_hole="/dev/null 2>&1"

# dead work
mkdir ${tmp_dir}

function make_install()
{
    cd ${pwd}/tools
    tar -xzf $1 -C ${tmp_dir}
    cd ${tmp_dir}/$1
    ./configure > ${black_hole}
    make > ${black_hole}
    sudo make install > ${black_hole}
    cd ${pwd}
}

#
# Latex
#
echo "Install LaTex..."
sudo apt-get install texlive-latex-base
sudo apt-get install latex-cjk-all
sudo apt-get install texlive-latex-extra

#
# Emacs
#
echo "Install and config Emacs..."
echo "        Configing Emacs..."
cd ${pwd}/emacs
cp -rf .emacs ~/
cp -rf .emacs.d ~/

echo "        Installing Cscope..."
make_install cscope*
sudo cp ${tmp_dir}/cscope*/contrib/xcscope/cscope-indexer /usr/bin
sudo chmod 755 /usr/bin/cscope-indexer
sed -i 's/cscope -b -i $LIST_FILE -f $DATABASE_FILE/cscope -q -b -i $LIST_FILE -f $DATABASE_FILE/' /usr/bin/cscope-indexer

echo "        Installing auctex..."
make_install auctex*

rm -rf ${tmp_dir}

exit 0