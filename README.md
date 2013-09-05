PHP-YAF-ppa
===========

YAF is a PHP framework written in c and built as a PHP extension.

You could use `PHP-YAF-ppa` deploy PHP-YAF into your Ubuntu OS easily.

Installing
----------

You must import PPA's key into your system and setup apt's sources.list first.
`add-apt-repository` can help us to take over the fussy job:

	sudo add-apt-repository ppa:mikespook/php5-yaf

Then you should tell your system to pull down the latest list:

	sudo apt-get update

Using `apt-get` to complete the installation:

	sudo apt-get install php5-yaf

After installing without error, you **MUST** restart your PHP process.

Eg. PHP FPM:

	sudo service php5-fpm restart

or Apache mod:

	sudo service apache2 restart

Maintainer
----------

 * Xing Xing <mikespook@gmail.com> [Blog](http://mikespook.com) [@Twitter](http://twitter.com/mikespook)

Open Source - MIT Software License
----------------------------------
Copyright (c) 2012 Xing Xing

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
