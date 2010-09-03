Return-Path: <Haiying.Wang@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id CA93BB718B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Sep 2010 00:50:24 +1000 (EST)
Subject: RE: P1021MDS QE Ethernet Ports
From: Haiying Wang <Haiying.Wang@freescale.com>
To: Ioannis Kokkoris <johnkokko@hotmail.com>
In-Reply-To: <COL120-W1B541E7CCFDA55F070E79A78D0@phx.gbl>
References: <COL120-W4274596E983E02BCBF4AD0A78B0@phx.gbl>
	,<COL120-W10FFCD057D88A833B4B46EA78C0@phx.gbl>
	,<1283434368.2904.2.camel@udp120119uds.am.freescale.net>
	<COL120-W1B541E7CCFDA55F070E79A78D0@phx.gbl>
Content-Type: text/plain
Date: Fri, 3 Sep 2010 10:39:47 -0400
Message-ID: <1283524788.2930.6.camel@udp120119uds.am.freescale.net>
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-03-09 at 10:05 +0300, Ioannis Kokkoris wrote:
> We are using a board revision 2 (pilot version). Our main concern is whether this issue affects the working UCC1 eth interface performance.
No, it won't affect the performance. We got line rate for performance
for UECs on this board.

> Do you think that removing or pulling-down R79 (pin 21@U11) will fix the problem with ENET1?
I don't know.

> > You can connect two UECs for your current development.
> 
> Do you mean that changing the ENET1 interface from UCC1 to UCC3 in dts may solve the problem?
No, I did not mean that. Only UCC1 and UCC5 are wired out for Ethernet
mode on this board, you can not change the UCC#. I meant, you should
have both UCC1/UCC5(ENET1/ENET5) connected with Ethernet cable.

Haiying
