PHP-YAF-PPA
===========

[YAF][1] is a PHP framework written in c and built as a PHP extension.

You could use [ppa][2] to deploy PHP-YAF into your Ubuntu OS easily.

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

Build PPA
---------

`build.sh` is a tool for helping build PHP-YAF-PPA.

	Usage: build.sh [-v2.2.9] [-i] [-craring]
		-v : Upstream version
		-i : Index version
		-c : Distribution's codename

`Upstream version` is YAF release version. Currently, the version is `2.2.9`.
If you want to build previous version, please specify it. 

`Index version` is the version for PPA, pure number required.

`Distribution's codename` is the release name of your Ubuntu. 
Using `lsb_release -c` to detect it.

For example, if want to build a new ppa release for Ubuntu 12.04 (precise) with
the newest YAF version.

	build.sh -v 2.2.9 -i 1 -c precise

Because the newest version of YAF is 2.2.9, in this case, `-v` could be omited.
If your host OS is Ubuntu 12.04, `-c` could be omited too.

After inputting the release note and checked the `changelog`, source.changes
file will be created. Read the [introduction][3] on the launchpad to know why
only source.changes file used.


Maintainer
----------

 * Xing Xing <mikespook@gmail.com> [Blog](http://mikespook.com) [@Twitter](http://twitter.com/mikespook)

Open Source - MIT Software License
----------------------------------
Copyright (c) 2012 Xing Xing

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[1]: https://github.com/laruence/php-yaf
[2]: https://launchpad.net/~mikespook/+archive/php5-yaf
[3]: https://help.launchpad.net/Packaging/PPA/Uploading
