Return-Path: <morelli.gab@libero.it>
Received: from smtp4.libero.it (smtp4.libero.it [193.70.192.54])
	by ozlabs.org (Postfix) with ESMTP id A648667A3E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 01:34:15 +1000 (EST)
Received: from localhost (172.16.1.15) by smtp4.libero.it (7.0.027-DD01)
	id 4499647A01B64852 for linuxppc-embedded@ozlabs.org;
	Tue, 11 Jul 2006 17:34:12 +0200
Received: from smtp0.libero.it ([172.16.1.204])
	by localhost (asav11.libero.it [193.70.192.93]) (amavisd-new,
	port 10024)
	with ESMTP id 30065-07-9 for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 17:34:12 +0200 (CEST)
Received: from libero.it (192.168.17.12) by smtp0.libero.it (7.0.027-DD01)
	id 44A3653A002EBE04 for linuxppc-embedded@ozlabs.org;
	Tue, 11 Jul 2006 17:34:12 +0200
Date: Tue, 11 Jul 2006 17:34:11 +0200
Message-Id: <J28WKZ$8C988C74E08A09A6007488B9247A52A2@libero.it>
Subject: No init found
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "morelli\.gab" <morelli.gab@libero.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

help!!

i not understand, because when load the Kernel-2.6 in my board the system=
 block on following message  

"Kernel panic - not syncing: No init found.  Try passing init=3D option t=
o kernel"
 
my filesystem contain the process init into folder sbin i build it whit a=
 busybox-1.1.3

...
mtdblock_open
ok
mtdblock: read on "cramfs" at 0x400, size 0x200
mtdblock: read on "cramfs" at 0x600, size 0x200
mtdblock_release
ok
mtdblock_open
ok
mtdblock: read on "cramfs" at 0x0, size 0x200
mtdblock: read on "cramfs" at 0x200, size 0x200
mtdblock: read on "cramfs" at 0x400, size 0x200
kernel panic........

thanks to all
