#! /bin/bash
wget https://www.python.org/ftp/python/3.12.4/Python-3.12.4.tgz
tar -zxvf Python-3.12.4.tgz
cd Python-3.12.4
mkdir ~/.localpython
./configure --prefix=/home/$USER/.localpython
make
make install
