#! /bin/sh

pwd=`pwd`
tmp_dir=`pwd`/tools/tmp

# dead work
mkdir ${tmp_dir}

#
# Emacs
#
echo "Install and config Emacs..."
echo "        Configing Emacs..."
cd ${pwd}/emacs
cp -rf .emacs ~/
cp -rf .emacs.d ~/
echo "        Installing Cscope..."
cd ${pwd}/tools
tar -xzf cscope* -C ${tmp_dir}
cd ${tmp_dir}/cscope*
./configure > /dev/null
make > /dev/null
sudo make install > /dev/null
sudo cp cscope-indexer /usr/bin
sudo chmod 755 /usr/bin/cscope-indexer
sed -i 's/cscope -b -i $LIST_FILE -f $DATABASE_FILE/cscope -q -b -i $LIST_FILE -f $DATABASE_FILE/' /usr/bin/cscope-indexer


rm -rf ${tmp_dir}