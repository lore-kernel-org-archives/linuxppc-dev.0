Return-Path: <iluri@fagorautomation.es>
Received: from sollube.sarenet.es (mx1.sarenet.es [194.30.0.37])
	by ozlabs.org (Postfix) with ESMTP id EEE60679F0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 19:14:51 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by sollube.sarenet.es (Postfix) with ESMTP id D2A19371FD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 08:54:14 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Subject: RE: buildroot  uClibc busybox and associated tool versions
Date: Tue, 14 Mar 2006 08:54:18 +0100
Message-ID: <918EB199DDDFFA42BEA2EB3A1C6021F3B5C6D8@correo.fagorautomation.net>
From: "IGOR LURI" <iluri@fagorautomation.es>
To: "Ben" <Ben@haliplex.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

We use the following version of uClibc , busybox , gcc , binutils
and kernel headers to build toolchain, rootfs, u-boot, rtai and linux =
kernel 2.4.25 for ppc5200:

gcc                     3.3.6
binutils                2.14.90.0.8
linux headers           2.4.29
gdb                     5.3
uClibc                  0.9.28
busybox                 1.0.0

If you want to use this toolchain to build linux kernel 2.6.x, you need =
other version of gcc, binutils and gdb.

Hope this helps.


-----Mensaje original-----
De: linuxppc-embedded-bounces+iluri=3Dfagorautomation.es@ozlabs.org
[mailto:linuxppc-embedded-bounces+iluri=3Dfagorautomation.es@ozlabs.org]E=
n
nombre de Ben
Enviado el: martes, 14 de marzo de 2006 2:48
Para: linuxppc-embedded@ozlabs.org
Asunto: buildroot uClibc busybox and associated tool versions


Hi all

Im looking for some info on what versions of uClibc , busybox , gcc , =
binutils
and kernel headers are best to use to build up a toolchain and rootfs =
for a 82xx
PPC. =20

I am using buildroot http://buildroot.uClibc.org  to generate the =
toolchain
associated tools and rootfs but so far have not had much luck.

The host machine i am compiling on is a dell poweredge 650 xeon server =
running
Fedora Core 3,   it has  gcc 3.4.2-6  binutils-2.15.92.0.2  glibc-2.3.3 =
and
linux version 2.6.9-1.667. =20

Im trying to compile up a rootfs for 82xx PPC with the following
gcc 4.0.2
binutils 2.16.1
Kernel headers 2.16.12
uClibc   - whatever version works best, right now i have daily snapshot =
20060113
busybox - whatever version works best, right now  i have snapshot from =
9th march
and am applying patches released from 9th march - 13th march.

Personally i think the choices of gcc , binutils and Kernel headers are =
fine,  i
seem to be having more trouble with the uClibc ver and busybox ver.=20

Last Friday 10th march selecting the daily snapshot of uClibc caused the
compilation to not get past the point of generating gcc and bin utils. =
Using the
daily snapshot version of busybox also caused compilation to fail with =
it
reporting lots of .os and .osm files missing in the libbb dir until i =
applied
todays patches.

Ive also tried building with use daily snapshot unchecked for busybox =
and uClibc
but compilation fails.=20

Surely someone out there must know what versions of everything are the =
best to
use to generate a toolchain and rootfs for PPC.

Any help anyone could give would be greatly appreciated






_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
