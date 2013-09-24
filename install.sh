#! /bin/sh

pwd=`pwd`
tmp_dir=`pwd`/tools/tmp

# dead work
mkdir ${tmp_dir}

#
# Emacs plugin
#
echo "Installing Emacs plugins..."
echo "        Config Emacs..."
cd ${pwd}/emacs
cp -rf .emacs ~/
cp -rf .emacs.d ~/
echo "        Installing Cscope..."
cd ${pwd}/tools
tar -xzf cscope* -C ${tmp_dir}
cd ${tmp_dir}/cscope*
./configure
make
sudo make install
sudo cp cscope-indexer /usr/bin
sudo chmod 755 /usr/bin/cscope-indexer



rm -rf ${tmp_dir}