From: Gérard Guével <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: What files are needed in ramdisk to allow module insertion
Date: Mon, 11 Dec 2000 20:20:10 +0100
Message-ID: <000201c063a7$81307a20$2901a8c0@none>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a proprietary MPC860P board with Hard Hat Linux 2.2.14.

When I use a NFS disk, I can insert new modules via the "insmod" command.
That works fine.

Now I want to make a ramdisk from Montavista target.
I can run httpd and several common binaries.
But when I want to insert a module, I have a segmentation fault.
I don't know what I forgot.


Below is my files list to generate the ramdisk
./bin/vi
./bin/mkdir
./bin/mount
./bin/bash
./bin/chmod
./bin/cp
./bin/echo
./bin/env
./bin/grep
./bin/htpasswd
./bin/httpd
./bin/id
./bin/ifconfig
./bin/inetd
./bin/insmod
./bin/ls
./bin/lsmod
./bin/mknod
./bin/mv
./bin/ping
./bin/ps
./bin/rm
./bin/rmmod
./bin/sh
./bin/su
./bin/flash.o
./bin/install_flash
./dev/console
./dev/core
./dev/full
./dev/initctl
./dev/kmem
./dev/fb
./dev/fb0
./dev/mem
./dev/null
./dev/port
./dev/ptyp0
./dev/ptyp1
./dev/ptyp2
./dev/ptyp3
./dev/ptyp4
./dev/ptyp5
./dev/ptyp6
./dev/ptyp7
./dev/ptyp8
./dev/ptyp9
./dev/ptypa
./dev/ptypb
./dev/ptypc
./dev/ptypd
./dev/ptype
./dev/ptypf
./dev/ram
./dev/ram1
./dev/ram2
./dev/ram3
./dev/tty
./dev/ttyS0
./dev/ttyS1
./dev/ttyp0
./dev/ttyp1
./dev/ttyp2
./dev/ttyp3
./dev/ttyp4
./dev/ttyp5
./dev/ttyp6
./dev/ttyp7
./dev/ttyp8
./dev/ttyp9
./dev/ttypa
./dev/ttypb
./dev/ttypc
./dev/ttypd
./dev/ttype
./dev/ttypf
./dev/zero
./lib/libm-2.1.3.so
./lib/libm.so
./lib/libm.so.6
./lib/ld-2.1.3.so
./lib/ld.so.1
./lib/libc-2.1.3.so
./lib/libc.so.6
./lib/libdl-2.1.3.so
./lib/libdl.so.2
./lib/libdl.so
./lib/libcrypt-2.1.3.so
./lib/libcrypt.so
./lib/libcrypt.so.1
./lib/libnss_compat-2.1.3.so
./lib/libnss_compat.so
./lib/libnss_compat.so.2
./lib/libnss_db-2.1.3.so
./lib/libnss_db.so
./lib/libnss_db.so.2
./lib/libnss_dns-2.1.3.so
./lib/libnss_dns.so
./lib/libnss_dns.so.2
./lib/libnss_files-2.1.3.so
./lib/libnss_files.so
./lib/libnss_files.so.2
./lib/libnss_hesiod-2.1.3.so
./lib/libnss_hesiod.so
./lib/libnss_hesiod.so.2
./lib/libnss_nis-2.1.3.so
./lib/libnss_nis.so
./lib/libnss_nis.so.2
./lib/libnss_nisplus-2.1.3.so
./lib/libnss_nisplus.so
./lib/libnss_nisplus.so.2
./lib/libresolv-2.1.3.so
./lib/libresolv.so.2
./lib/libresolv.so
./lib/libtermcap.so.2.0.8
./lib/libtermcap.so.2
./lib/libtermcap.so
./lib/libutil-2.1.3.so
./lib/libutil.so
./lib/libutil.so.1
./lib/libproc.so
./lib/libproc.so.2.0.0
./lib/apache/httpd.exp
./lib/apache/mod_auth.so
./lib/apache/mod_imap.so
./lib/apache/mod_setenvif.so
./lib/apache/mod_access.so
./lib/apache/mod_autoindex.so
./lib/apache/mod_include.so
./lib/apache/mod_status.so
./lib/apache/mod_actions.so
./lib/apache/mod_cgi.so
./lib/apache/mod_log_config.so
./lib/apache/mod_userdir.so
./lib/apache/mod_alias.so
./lib/apache/mod_dir.so
./lib/apache/mod_mime.so
./lib/apache/mod_asis.so
./lib/apache/mod_env.so
./lib/apache/mod_negotiation.so
./opt/hardhat/devkit/ppc/8xx/powerpc-hardhat-linux
./etc/DIR_COLORS
./etc/fstab
./etc/group
./etc/inetd.conf
./etc/inittab
./etc/ioctl.save
./etc/mtab
./etc/passwd
./etc/protocols
./etc/rc.sysinit
./etc/rpc
./etc/services
./etc/termcap
./etc/httpd/logs
./etc/httpd/modules
./etc/httpd/conf/access.conf
./etc/httpd/conf/httpd.conf
./etc/httpd/conf/magic
./etc/httpd/conf/mime.types
./etc/httpd/conf/srm.conf
./etc/httpd/conf/users
./sbin
./var/log/httpd/access_log
./var/log/httpd/error_log
./var/run/httpd.pid
./var/run/inetd.pid

Any help would be welcome.

Thanks to all :-)

G. Guével


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
