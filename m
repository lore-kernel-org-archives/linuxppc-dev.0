Return-Path: <siju@india.tejasnetworks.com>
Received: from anche.india.tejasnetworks.com (india.tejasnetworks.com
	[164.164.94.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43A5E67B6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 17:13:51 +1100 (EST)
Subject: "transmit timed out" on FCC in MPC8260 as well as MPC8247
From: Siju Viswanath K E <siju@india.tejasnetworks.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Message-Id: <1143177651.22246.3.camel@Blaze>
Mime-Version: 1.0
Date: 24 Mar 2006 10:50:51 +0530
Cc: siju@india.tejasnetworks.com
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
	I am using denk's linuxppc-2.4.20 . I am getting this problem of
"transmit timed out" on FCC in MPC8260 as well as MPC8247. It seems to
be a case of late collision. I checked out earlier posts similar to this
also. The problem occurs if I attempt to transfer large files and is not
seen on all systems.

	The messages on console are given below. I am seeing the
same 5th BD reporting LC. FCC_PSMR_LPB is already set in
arch/ppc/8260_io/fcc_enet.c .

	Can the 8247 errata CPM119 or some other errata be the cause ? What is
the solution for this ?
 
console messages:
 
NETDEV WATCHDOG: eth0: transmit timed out
 
eth0: transmit timed out.
 
 Ring data dump: cur_tx c01ef560 (full) cur_rx c01ef4d0.
 
 Tx @base c01ef508 :
 
5c00 0036 016d7da2
 
1c00 003e 00c25892
 
5c00 0036 00c2529a
 
1c00 0121 066b489a
 
1c00 05ea 0652e89a
 
1c80 01f0 0652e09a
 
9c00 0056 00c25c7a
 
9c00 003e 00c25e92
 
9c00 0056 00ad527a
 
9c00 003e 00ad5092
 
dc00 0036 00ad549a
 
9c00 004e 00c25682
 
1c00 003e 00c25492
 
5c00 0036 00c25a9a
 
1c00 0123 065c009a
 
3c00 040d 066b409a
 
 Rx @base c01ef408 :
 
9c00 0040 07b34000
 
<deleted>
 
bc00 0040 07b25800
 
 
+++++++++++++++++ similar problems ++++++++++++++++++++
 
1. http://patchwork.ozlabs.org/linuxppc/patch?id=1853
 
2. From: hubert loewenguth <hubert.loewenguth@thales-bm.com>
To: linuxppc-embedded@ozlabs.org
Subject: MPC8260 fcc_enet transmit timed out
Date: Mon, 14 Nov 2005 18:34:32 +0100

<deleted>
I have found some personns in this mailling list who has encounter a
problem wich seems similar:
 
http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016539.html
http://ozlabs.org/pipermail/linuxppc-embedded/2001-December/005714.html
<deleted>
+++++++++++++++++ similar problems ++++++++++++++++++++
 
Thanks,
Siju Viswanath K E
Tejas Networks
