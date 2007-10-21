Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id DBA27DDE9F
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Oct 2007 19:45:56 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Li Yang-r58472'" <LeoLi@freescale.com>,
	"'Netdev'" <netdev@vger.kernel.org>, <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH] Fix ethernet multicast for ucc_geth.
Date: Sun, 21 Oct 2007 11:45:48 +0200
Message-ID: <005801c813c7$2936b550$5267a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <989B956029373F45A0B8AF0297081890019B5BD2@zch01exm26.fsl.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Li Yang-r58472 [mailto:LeoLi@freescale.com] 
> Sent: den 18 oktober 2007 16:24
> To: joakim.tjernlund@transmode.se; Netdev; linuxppc-dev@ozlabs.org
> Subject: RE: [PATCH] Fix ethernet multicast for ucc_geth.
> 
> > -----Original Message-----
> > From: Joakim Tjernlund [mailto:joakim.tjernlund@transmode.se] 
> > Sent: Wednesday, October 17, 2007 5:06 PM
> > To: Netdev; Li Yang-r58472
> > Subject: [PATCH] Fix ethernet multicast for ucc_geth.
> > 
> > >From 5761a9e5924b34615c748fba2dcb977ed04c1243 Mon Sep 17 
> > 00:00:00 2001
> > From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> > Date: Wed, 17 Oct 2007 11:01:44 +0200
> > Subject: [PATCH] Fix ethernet multicast for ucc_geth.
> >  hw_add_addr_in_hash() already swaps byte  order, don't do it 
> > in ucc_geth_set_multi() too.
> > 
> > 
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> 
> Acked-by: Li Yang <leoli@freescale.com>
> 

Ping? Did this make into a someones tree?

 Jocke
