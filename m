Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 2D5E567C3E
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Dec 2006 10:05:01 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Timur Tabi'" <timur@freescale.com>
Subject: RE: latest linux git doesn't compile ucc_geth_phy.c and ucc_geth.c
Date: Mon, 18 Dec 2006 00:04:56 +0100
Message-ID: <00b001c7222f$c4d63b50$1e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <45803CE3.4030600@freescale.com>
Cc: 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Timur Tabi [mailto:timur@freescale.com] 
> Sent: den 13 december 2006 18:48
> To: joakim.tjernlund@transmode.se
> Cc: linuxppc-dev
> Subject: Re: latest linux git doesn't compile ucc_geth_phy.c 
> and ucc_geth.c
> 
> Joakim Tjernlund wrote:
> > drivers/net/ucc_geth.c:4083:45: macro "INIT_WORK" passed 3 
> arguments,
> > but takes just 2
> > drivers/net/ucc_geth.c: In function `ucc_geth_open':
> > drivers/net/ucc_geth.c:4083: error: `INIT_WORK' undeclared 
> (first use in
> > this function)
> > drivers/net/ucc_geth.c:4083: error: (Each undeclared identifier is
> > reported only once
> > drivers/net/ucc_geth.c:4083: error: for each function it 
> appears in.)
> > drivers/net/ucc_geth.c: At top level:
> > drivers/net/ucc_geth.c:3924: warning: 'ugeth_phy_change' 
> defined but not
> > used
> > make[2]: *** [drivers/net/ucc_geth.o] Error 1
> > 
> > drivers/net/ucc_geth_phy.c:71: error: conflicting types for 
> 'phy_read'
> > include/linux/phy.h:355: error: previous declaration of 
> 'phy_read' was
> > here
> > drivers/net/ucc_geth_phy.c:71: error: conflicting types for 
> 'phy_read'
> > include/linux/phy.h:355: error: previous declaration of 
> 'phy_read' was
> > here
> > drivers/net/ucc_geth_phy.c:72: error: conflicting types for 
> 'phy_write'
> > include/linux/phy.h:356: error: previous declaration of 
> 'phy_write' was
> > here
> > drivers/net/ucc_geth_phy.c:72: error: conflicting types for 
> 'phy_write'
> > include/linux/phy.h:356: error: previous declaration of 
> 'phy_write' was
> > here
> 
> I just posted two patches to linuxppc-dev that fix these 
> problems.  The message 
> are titled:
> 
> [PATCH] Update ucc_geth.c for new workqueue structure
> [PATCH] Fix phy_read/write redefinition errors in ucc_geth_phy.c
> 
> I've tested these on an 8360EMDS, and Kumar has reviewed and 
> signed off on the 
> code, so I think they're good.  Please let me know if they're not.

Has these been sent upstream yet? Didn't se them in linux tree as of now.

 Jocke
