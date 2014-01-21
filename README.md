Steps
-----

  * Prepare preinst, postinst, prerm, postrm

  * Prepare control file:
 
    Package: xxxxxx
    Version: 0.0.1
    Section: user/hidden 
    Priority: optional
    Architecture: all
    Maintainer: Fredrik Wendt <fredrik.wendt@squeed.com>

  * Produce archives:

    target/deb/data.tar.gz - files to install
    target/deb/control.tar.gz - control files

  * Package deb file:

    cd target/deb ; ar -r ../$package-$version.deb debian-binary control.tar.gz data.tar.gz

