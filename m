Return-Path: <morelli.gab@virgilio.it>
Received: from vsmtp3.tin.it (vsmtp3alice.tin.it [212.216.176.143])
	by ozlabs.org (Postfix) with ESMTP id AD69267B5E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Jul 2006 02:12:01 +1000 (EST)
Received: from mcmurphy (82.57.47.182) by vsmtp3.tin.it (7.2.072.1)
	id 44AA775D0028FFA1 for linuxppc-embedded@ozlabs.org;
	Wed, 5 Jul 2006 18:14:15 +0200
Message-ID: <44AA775D0028FFA1@vsmtp3.tin.it> (added by postmaster@virgilio.it)
Date: Wed, 5 Jul 2006 18:12:01 +0200
From: "Gabriele" <morelli.gab@virgilio.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: append a correct "root= boot option"
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

help me

I upgrade  the linux Kernel from 2.4 to 2.6, but i don't succeed  to Configurate the mtd.

Creating 4 MTD partitions on "EVBOARD875-0":
0x00000000-0x00060000 : "u-boot"
0x00060000-0x00160000 : "kernel"
0x00160000-0x004fa000 : "cramfs"
mtd: partition "cramfs" doesn't end on an erase block -- force read-only
0x00500000-0x00806000 : "jffs2"

obtain the follw message:

"Please append a correct "root= boot option"

from what can to depend? 

thanks to all 

 Gabriele
morelli.gab@virgilio.it
2006-07-05
