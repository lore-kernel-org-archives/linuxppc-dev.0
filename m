Return-Path: <nschichan@freebox.fr>
Received: from smtp4-g19.free.fr (smtp4-g19.free.fr [212.27.42.30])
	by ozlabs.org (Postfix) with ESMTP id 63251DDED1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 22:05:13 +1000 (EST)
Received: from smtp4-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 8FC106F449
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 14:05:11 +0200 (CEST)
Received: from bobafett.staff.proxad.net (bobafett.staff.proxad.net
	[213.228.1.121])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 8D2B66F402
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 14:05:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id 2A1C028790
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 14:05:08 +0200 (CEST)
Received: from bobafett.staff.proxad.net ([127.0.0.1])
	by localhost (bobafett.staff.proxad.net [127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 0YmRiC3bB4Sw for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 14:05:06 +0200 (CEST)
Received: from nschichan.priv.staff.proxad.net
	(nschichan.priv.staff.proxad.net [172.18.3.120])
	by bobafett.staff.proxad.net (Postfix) with ESMTP id E41122864C
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 14:05:06 +0200 (CEST)
From: Nicolas Schichan <nschichan@freebox.fr>
To: linuxppc-embedded@ozlabs.org
Subject: random panic and freezes on mpc8349 itx
Date: Fri, 7 Sep 2007 14:05:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709071405.06500.nschichan@freebox.fr>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I am currently working with an MPC8349ITX board and I have some trouble with 
the kernel as soon as it reaches userland.

If I boot the kernel with all the memory (256MB) available (no mem=... on the 
command line), I get random freezes or random kernel panics. Some times it 
won't even run init. Some times it will panic badly if I try to put some 
pressure to the system (stress --cpu 256). Some times it will hang 
immediately after logging in, ...

If I boot the kernel with mem=64M, these freeze and random panic disapear and 
I am able to run the stress program without any problems.

I have had this strange behaviour on both kernel 2.6.20 and 2.6.22 with 
mpc834x_itx_defconfig (both from kernel.org) (ARCH=powerpc).

I am inclined to say that it is not a broken RAM chip problem because if I use 
a 2.6.17 from kernel.org with all the RAM available (ARCH=ppc) configured 
with mpc834x_sys_defconfig (there was no defconfig for the itx board on this 
version) everything runs fine and I am able to run the stress program without 
any problems.

The panic does not happen very often, 90% of the time, the board hangs and 
stops responding to ping. When a panic do happen it is almost always in a 
different place.

Does any of you have met this problem before ? If you have any clues about 
what is hapenning I'd be glad to hear about it :)

Thank you for your attention,

Regards,

-- 
Nicolas Schichan
