#!/bin/bash

current="`pwd`"
cd $current/php5-yaf

debuild clean
rm *.tar.gz
rm php-yaf_*
