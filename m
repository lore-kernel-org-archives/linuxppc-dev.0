Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3F1F8738.3040209@imc-berlin.de>
Date: Thu, 24 Jul 2003 09:14:00 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Problems rebuilding the DENX ELDK
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I am trying to rebuild the great DENX's ELDK from scratch.
My host is a SuSE 8.2 system.
The first obstacle is that some packages won't build with recent
automake/autoconf version. So I got some old versions built and
installed them on my system.

Now the first step - build the RPM - works. I do get a rpm binary in
/opt/eldk/build/ppc-2003-07-23/work/bin

But the next step - build the target RPM from eldt - fails:

The log shows:

+ CFLAGS=-O2 -march=i386 -mcpu=i686
+ ./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
'--infodir=${prefix}/share/info' '--mandir=${prefix}/share/man'
--enable-shared=no --enable-static=yes --with-target-arch=ppc
creating cache ./config.cache
...
Finding  Provides: (using
/opt/eldk/build/ppc-2003-07-23/work/usr/lib/rpm/find-provides)...
PreReq: /bin/sh /bin/sh rpmlib(CompressedFileNames) <= 3.0.4-1
Requires(interp): /bin/sh /bin/sh
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
Requires(pre): /bin/sh
Requires(post): /bin/sh
Conflicts: patch < 2.5
Processing files: rpm-devel-4.0.3-1.03b_3
Executing(%doc): /bin/sh -e
/opt/eldk/build/ppc-2003-07-23/work/var/tmp/rpm-tmp.42006
+ umask 022
+ cd /opt/eldk/build/ppc-2003-07-23/work/usr/src/denx/BUILD
+ cd rpm-4.0.3
+
DOCDIR=/opt/eldk/build/ppc-2003-07-23/work/var/tmp/rpm-root/usr/share/doc/rpm-devel-4.0.3
+ export DOCDIR
+ rm -rf
/opt/eldk/build/ppc-2003-07-23/work/var/tmp/rpm-root/usr/share/doc/rpm-devel-4.0.3
+ /bin/mkdir -p
/opt/eldk/build/ppc-2003-07-23/work/var/tmp/rpm-root/usr/share/doc/rpm-devel-4.0.3
+ cp -pr apidocs
/opt/eldk/build/ppc-2003-07-23/work/var/tmp/rpm-root/usr/share/doc/rpm-devel-4.0.3
+ exit 0
Finding  Provides: (using
/opt/eldk/build/ppc-2003-07-23/work/usr/lib/rpm/find-provides)...
PreReq: rpmlib(CompressedFileNames) <= 3.0.4-1
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
Requires: rpm = 4.0.3
Processing files: rpm-build-4.0.3-1.03b_3
Finding  Provides: (using
/opt/eldk/build/ppc-2003-07-23/work/usr/lib/rpm/find-provides)...
PreReq: rpmlib(CompressedFileNames) <= 3.0.4-1
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
Requires: rpm = 4.0.3
Processing files: popt-1.6.3-1.03b_3
Finding  Provides: (using
/opt/eldk/build/ppc-2003-07-23/work/usr/lib/rpm/find-provides)...
PreReq: rpmlib(CompressedFileNames) <= 3.0.4-1
Requires(rpmlib): rpmlib(CompressedFileNames) <= 3.0.4-1
error: /opt/eldk/build/ppc-2003-07-23/work/var/tmp/rpm-tmp.62141:
Fseek failed: Invalid argument


????


I am confused! 3.0.4 is the version of rpm that comes with SuSE 8.2.
But I thought ELDK builds the rpm with "--enable-static=yes". So why
is he asking for "rpmlib(CompressedFileNames) <= 3.0.4-1" ???

Thanks a million!

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
