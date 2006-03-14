Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ACBD9679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 14:05:31 +1100 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1FIypf-0001Eo-Dj
	for linuxppc-embedded@ozlabs.org; Tue, 14 Mar 2006 03:00:19 +0100
Received: from dsl-202-45-109-210-static.VIC.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 14 Mar 2006 03:00:19 +0100
Received: from Ben by dsl-202-45-109-210-static.VIC.netspace.net.au with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 14 Mar 2006 03:00:19 +0100
To: linuxppc-embedded@ozlabs.org
From: Ben <Ben@haliplex.com>
Subject: buildroot  uClibc busybox and associated tool versions
Date: Tue, 14 Mar 2006 01:48:22 +0000 (UTC)
Message-ID: <loom.20060314T023032-451@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all

Im looking for some info on what versions of uClibc , busybox , gcc , binutils
and kernel headers are best to use to build up a toolchain and rootfs for a 82xx
PPC.  

I am using buildroot http://buildroot.uClibc.org  to generate the toolchain
associated tools and rootfs but so far have not had much luck.

The host machine i am compiling on is a dell poweredge 650 xeon server running
Fedora Core 3,   it has  gcc 3.4.2-6  binutils-2.15.92.0.2  glibc-2.3.3 and
linux version 2.6.9-1.667.  

Im trying to compile up a rootfs for 82xx PPC with the following
gcc 4.0.2
binutils 2.16.1
Kernel headers 2.16.12
uClibc   - whatever version works best, right now i have daily snapshot 20060113
busybox - whatever version works best, right now  i have snapshot from 9th march
and am applying patches released from 9th march - 13th march.

Personally i think the choices of gcc , binutils and Kernel headers are fine,  i
seem to be having more trouble with the uClibc ver and busybox ver. 

Last Friday 10th march selecting the daily snapshot of uClibc caused the
compilation to not get past the point of generating gcc and bin utils. Using the
daily snapshot version of busybox also caused compilation to fail with it
reporting lots of .os and .osm files missing in the libbb dir until i applied
todays patches.

Ive also tried building with use daily snapshot unchecked for busybox and uClibc
but compilation fails. 

Surely someone out there must know what versions of everything are the best to
use to generate a toolchain and rootfs for PPC.

Any help anyone could give would be greatly appreciated
